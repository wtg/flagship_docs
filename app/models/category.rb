class Category < ActiveRecord::Base
  acts_as_category :order_by => 'name', :hidden => 'private'
  
  #Validation
  validates_presence_of :name, :group_id, :user_id

  #Relationships
  belongs_to :group
  belongs_to :user
  has_many :documents, :dependent => :nullify
  belongs_to :background

  accepts_nested_attributes_for :background, :allow_destroy => true, :reject_if => proc { |attrs| attrs['image'].blank? }

  #Indexing
  define_index do
    indexes name
    indexes description
  end
  

  #All the documents in a category, sorted by their last update.
  #This is needed until a bug in activerecord is fixed. (see below)
  #https://rails.lighthouseapp.com/projects/8994/tickets/2346-named_scope-doesnt-override-default_scopes-order-key
  def documents_by_updated
    Document.find(:all, :conditions => {:category_id => self.id}, :order => 'updated_at DESC')
  end

  #Return the reverse of private, for reading purposes
  def not_private
    !self.private
  end

  #Test if the current user is a member of the owning group
  def current_user_in_my_group?
    result = false
    bypass_auth do
      #bypass authentication allows us to looka at the accessor and group, or something
      if !ActiveRecord::Base.accessor.nil? && ActiveRecord::Base.accessor.in_group?( group )
        result=true
      else
        result = false
      end
    end
    return result || false
  end

  #Authenticates Access
  has_owner :user
  autosets_owner_on_create

  #Test if a user can read a category
  #This method bypasses the acts_as_category plugin methods
  authenticates_reads :with => :not_private
  authenticates_reads :with => :allow_owner
  authenticates_reads :with_accessor_method => :is_admin
  authenticates_reads :with => :current_user_in_my_group?

  #Test if a user can write to the category
  authenticates_saves :with => :allow_owner
  authenticates_saves :with => :writable
  authenticates_saves :with_accessor_method => :is_admin
  authenticates_saves :with => :current_user_in_my_group?

end
