class Group < ActiveRecord::Base

  #Scoping
  default_scope :order => 'name ASC'
  
  #Validations
  validates_presence_of :name
  
  #Test if the current user is a member of this group
  def current_user_in_my_group?
    result = false
    bypass_auth do
      #bypass authentication allows us to looka at the accessor and group, or something
      if !ActiveRecord::Base.accessor.nil? && ActiveRecord::Base.accessor.in_group?( self )
        result=true
      else
        result = false
      end
    end
    return result || false
  end

  #Relationships
  has_and_belongs_to_many :users, :order => 'username ASC'
  belongs_to :leader, :class_name => 'User', :foreign_key => 'group_leader_id'
	has_many :categorys

  has_owner :group_leader
  authenticates_creation :with_accessor_method => :is_admin
  
  authenticates_saves :with => :allow_owner
  authenticates_saves :with_accessor_method => :is_admin
  
  authenticates_reads :with => :allow_owner
  authenticates_reads :with_accessor_method => :is_admin
  authenticates_reads :with => :current_user_in_my_group?
  
  
end
