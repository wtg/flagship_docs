class User < ActiveRecord::Base

  #Validations
  validates_presence_of :username, :full_name

  #Relationships
  has_and_belongs_to_many :groups
  has_many :revisions
  has_many :documents
end
