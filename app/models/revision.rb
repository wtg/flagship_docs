class Revision < ActiveRecord::Base
  acts_as_list :scope => :document

  default_scope :order => 'position DESC'
  
  #Relationships
  belongs_to :document
  belongs_to :user

  def current?
    return Document.current.id == self.id
  end
end
