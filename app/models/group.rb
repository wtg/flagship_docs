class Group < ActiveRecord::Base

  #Validations
  validates_presence_of :name

  #Relationships
  has_and_belongs_to_many :users
	belongs_to :leader, :class_name => 'User', :foreign_key => 'group_leader_id'

	has_owner :group_leader
	authenticates_creation :with_accessor_method => :is_admin
	authenticates_saves :with => :allow_owner
	authenticates_saves :with_accessor_method => :is_admin
end
