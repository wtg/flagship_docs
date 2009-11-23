class Group < ActiveRecord::Base

  #Relationships
  has_and_belongs_to_many :users
end
