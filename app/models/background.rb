class Background < ActiveRecord::Base

  #Relationships
  has_many :categories

  #Attachment
  has_attached_file :image

	#Methods

	#Checks to see if a user can upload new backgrounds
	#Three Types of People can create new backgrounds. Super Admins, Group Members, and Group Leaders
	#The Check for Group Leaders really isn't required, you need to be a group member to lead it generally,
	#but sticky things can happen. You never know what the user will do.

	authenticates_saves :with_accessor_method => :is_admin
	#authenticates_saves :with => IN_A_GROUP
=begin
	def can_upload
		#if user is an admin he can do this.
		if current_user.is_admin
			true
		#if user is in a group he can do this.
		elsif current_user.groups.count > 0
			true
		#if user is a group leader he can do this.
		elsif current_user.groups_led.count > 0
			true
		#the user can't do this.
		else
			false
		end
	end
=end
end
