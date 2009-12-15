class Document < ActiveRecord::Base
  
  #Validation
  validates_presence_of :title, :category_id

  #Relationships
  has_many :revisions, :order => "position DESC"
  belongs_to :category
  belongs_to :user

  accepts_nested_attributes_for :revisions, :allow_destroy => true

  #Indexing
  acts_as_ferret :fields => [ :title, :description ]
  
  #Return current document
  def current_revision
    Revision.find(:first, :conditions => {:document_id => self.id})
  end
end
