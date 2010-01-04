class Document < ActiveRecord::Base
  
  #Validation
  validates_presence_of :title, :category_id

  #Relationships
  has_many :revisions, :order => "position DESC"
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
    self.category.group
  end
  
  #If a user has access to read a document (and its revisions)
  def can_read(user = nil)
    if user.nil? && !self.readable
      #Public users cannot access non readible documents
      false
    elsif self.readable
      #Publically readible documents can be read by all
      true
    elsif self.user == user
      true
    elsif self.category.group.users.include?(user)
      true
    else
      false
    end  
  end
  
  #If a user has access to write/update to a document
  def can_write(user)
    if self.writable
      #Publically writable documents
      true
    elsif self.user == user
      #The owner can always write to a document
      true
    elsif self.category.group.users.include?(user)
      #Members of the category can always write to it as well
      true
    else
      false
    end
  end
end
