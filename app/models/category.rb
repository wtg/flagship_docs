class Category < ActiveRecord::Base
  acts_as_category :order => 'name', :hidden => 'private'
  
  #Validation
  validates_presence_of :name, :group_id, :user_id

  #Relationships
  belongs_to :group
  belongs_to :user
  has_many :documents

  def full_path()
    return self.name
  end
end
