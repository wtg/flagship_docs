class Group < ActiveRecord::Base

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  has_many :members, -> {where(level: Membership::LEVELS[:regular])}, :through => :memberships, :source => :user
  has_many :leaders, -> {where(level: Membership::LEVELS[:leader])}, :through => :memberships, :source => :user

end