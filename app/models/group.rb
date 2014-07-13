class Group < ActiveRecord::Base

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  has_many :members, through: :memberships, 
              source: :user, conditions: {"memberships.level" => Membership::LEVELS[:regular]}
  has_many :leaders, through: :memberships, 
              source: :user, conditions: {"memberships.level" => Membership::LEVELS[:leader]}
end