class Category < ActiveRecord::Base
  acts_as_category :order => 'name', :hidden => 'private'
  
  #Validation
  validates_presence_of :name, :group_id, :user_id

  #Relationships
  belongs_to :group
  belongs_to :user
  has_many :documents
  belongs_to :background

  #Indexing
  acts_as_ferret :fields => [ :name, :description ]

  #All the documents in a category, sorted by their last update.
  #This is needed until a bug in activerecord is fixed. (see below)
  #https://rails.lighthouseapp.com/projects/8994/tickets/2346-named_scope-doesnt-override-default_scopes-order-key
  def documents_by_updated
    Document.find(:all, :conditions => {:category_id => self.id}, :order => 'updated_at DESC')
  end

  #Test if a user can write to a read
  #This method bypasses the acts_as_category plugin methods
  def can_read(current_user)
   if current_user == user.nil? && self.private
      #Public users cannot access private
      false
    elsif !self.private
      #Not private categories can be read by all
      true
    elsif self.user == current_user
      true
    elsif self.group.users.include?(current_user)
      true
    else
      false
    end  
  end


  #Test if a user can write to the category
  def can_write(current_user)
    if self.writable
      #Anyone can write to a category that is publically writable
      true
    elsif self.group.users.include?(current_user)
      #A member of the owning group can write as well
      true
    elsif self.is_owner(current_user)
      #The user who owns the category can write to it
      true
    else
      #Otherwise, no one can write
      false
    end
  end
  
  #Test if the user can admin the category or not. Added a check if the user is a super_admin
  def is_owner(current_user)
    self.user == current_user || (!current_user.blank? && current_user.is_admin)
  end

end
