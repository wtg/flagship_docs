class Group < ActiveRecord::Base

  #Relationships
  has_and_belongs_to_many :users
	belongs_to :leader, :class_name => 'User', :foreign_key => 'group_leader_id'
	#Methods

	#Need to make a decision as to who can add members. Group Members? Or Just the Leader?
	#It makes sense that only a leader can delete members,though. I'm not sure about my first question.
	#If we decide that only leaders should be able to edit, we only need one function, a can_edit_members.
	#Instead of two, a can_add_members and can_delete_members.
	
	has_owner :leader
	authenticates_creation :with_accessor_method => :is_admin
	authenticates_saves :with => :allow_owner
	authenticates_saves :with_accessor_method => :is_admin
=begin
	def can_add_members
		#admins can add members to a group
		if current_user.is_admin
			true
		#leaders of groups can add members
		elsif current_user == self.leader
			true
		#group members can currently add members too, we should decide on whether we want to do this though
		elsif self.users.include?(current_user)
			true
		#no one else is allowed to add members
		else
			false
		end
	end

	def can_remove_members
		#admins can remove members from a group
		if current_user.is_admin
			true
		#leaders of groups can remove members
		elsif current_user == self.leader
			true
		#no one else is allowed to add members
		else
			false
		end
	end
=end
end
