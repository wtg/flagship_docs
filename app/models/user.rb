class User < ActiveRecord::Base

  #Validations
  validates_presence_of :username, :full_name

  #Relationships
  has_and_belongs_to_many :groups
  has_many :revisions
  has_many :documents
	has_many :groups_led, :class_name => 'Group' , :foreign_key => 'group_leader_id'

	#Methods

	#Only Admins Can Create a New User, If at all. Needs to be discussed.
	#Should we be able to manually add users?
	def can_create_user
		if self.is_admin
			true
		end
	end
end
