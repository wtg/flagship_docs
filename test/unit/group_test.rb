require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  fixtures :users, :groups

  def test_validation
    group = Group.new
    assert !group.valid?

    group.name = ""
    assert !group.valid?
  end

  def test_fields
    group = Group.new({:name => "test"})
    assert_equal group.name, "test"
  end  

  def test_leader
    cool_kids = groups(:cool_kids)
    assert_equal cool_kids.leader, users(:groupie)
  end

  def test_group_membership
    groupie = users(:groupie) #Member of one group
    patron = users(:patron) #Member of two groups
    regular = users(:regular) #Member of 0 groups

    cool_kids = groups(:cool_kids) #Has 2 members
    patroons = groups(:patroons) #Has 1 member

    #Test associations
    assert cool_kids.users.include?(groupie)
    assert !patroons.users.include?(groupie)
  end

end
