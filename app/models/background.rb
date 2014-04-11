class Background < ActiveRecord::Base

  #Relationships
  has_many :categories

  #Attachment
  has_attached_file :image, 
      :styles => { 
          :thumb => ["125x95#", :png],
          :standard => ["800x1200", :jpg]
      }

  #Validation
  validates_attachment_presence :image



	#Methods

	#Checks to see if a user can upload new backgrounds
	#Three Types of People can create new backgrounds. Super Admins, Group Members, and Group Leaders
	#The Check for Group Leaders really isn't required, you need to be a group member to lead it generally,
	#but sticky things can happen. You never know what the user will do.
	authenticates_saves :with_accessor_method => :is_admin
	authenticates_saves :with_accessor_method => :in_one_group
end
