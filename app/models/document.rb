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
	has_owner :user
	autosets_owner_on_create
	
	authenticates_reads :with_accessor_method => :is_admin
	authenticates_reads :with => :allow_owner
	authenticates_reads :with => :readable
	#authenticates_reads :with => IS_IN_GROUP

	authenticates_saves :with => :writeable
	authenticates_saves :with => :allow_owner
	authenticates_saves :with_accessor_method => :is_admin
	#authenticates_saves :with => IS_IN_GROUP

end
