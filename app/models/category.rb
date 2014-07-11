class Category < ActiveRecord::Base
  include ActsAsCategory

  acts_as_category :order_by => 'name', :hidden => 'private'

  validates_presence_of :name, :group_id, :user_id

end
