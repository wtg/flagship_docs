class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  LEVELS = {
    :regular => 1,
    :manager => 9,
  }

  scope :regular_member, where(:level => Membership::LEVELS[:regular])
  scope :manager, where(:level => Membership::LEVELS[:manager])
end
