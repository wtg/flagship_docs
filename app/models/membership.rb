class Membership < ActiveRecord::Base

  belongs_to :group
  belongs_to :user

  validates :user_id, uniqueness: {scope: [:level, :group_id]}

  LEVELS = {
    regular: 1,
    leader: 9
  }

  scope :regular_member, -> {where(level: Membership::LEVELS[:regular])}
  scope :leader, -> {where(level: Membership::LEVELS[:leader])}

end
