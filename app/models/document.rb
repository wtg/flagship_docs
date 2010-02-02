class Document < ActiveRecord::Base
  
  #Validation
  validates_presence_of :title, :category_id, :user_id

  #Relationships
  has_many :revisions, :order => "position DESC", :dependent => :destroy
  belongs_to :category
  belongs_to :user

  accepts_nested_attributes_for :revisions, :allow_destroy => true

  #Indexing
  acts_as_ferret :fields => { :title  => {:store => :yes}, :description => {:store => :yes}}, :additional_fields => { :current_revision_text => {:store => :yes}}
  
  #Scoping
  default_scope :order => 'title ASC'
  named_scope :by_updated, :order => 'updated_at DESC'

  #Return current document
  def current_revision
    Revision.find(:first, :conditions => {:document_id => self.id})
  end

  #Try to extract some text from the current revision
  def current_revision_text
    revision = self.current_revision
    revision.text
  end

  #The group that is responsible for this document.  Inherited from the category the document belongs to.
  def group
    if !self.category.nil?
      self.category.group
    else
      nil
    end
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

  #Determine who can read this document	
  authenticates_reads :with_accessor_method => :is_admin
  authenticates_reads :with => :allow_owner
  authenticates_reads :with => :readable
  authenticates_reads :with => :current_user_in_my_group?

  #Determine who can write/update this document
  authenticates_saves :with => :writable
  authenticates_saves :with => :allow_owner
  authenticates_saves :with_accessor_method => :is_admin
  authenticates_saves :with => :current_user_in_my_group?

end
