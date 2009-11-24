class Revision < ActiveRecord::Base
  acts_as_list :scope => :document

  has_attached_file :upload, :storage => :database
 
  default_scope select_without_file_columns_for(:upload).merge({:order => 'position DESC'})

  #Relationships
  belongs_to :document
  belongs_to :user

  def current?
    return Document.current.id == self.id
  end
end
