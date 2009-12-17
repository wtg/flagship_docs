class Document < ActiveRecord::Base
  
  #Validation
  validates_presence_of :title, :category_id

  #Relationships
  has_many :revisions, :order => "position DESC"
  belongs_to :category
  belongs_to :user

  accepts_nested_attributes_for :revisions, :allow_destroy => true

  #Indexing
  acts_as_ferret :fields => [ :title, :description ], :additional_fields => [ :current_revision_text ]
  
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
end
