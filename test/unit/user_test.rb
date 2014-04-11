require 'test_helper'

class UserTest < ActiveSupport::TestCase

  fixtures :users, :groups

  def test_validation
    user = User.new
    assert !user.valid?

    user.username = ""
    assert !user.valid?

    user.full_name = ""
    assert !user.valid?

    user.username = "Test"
    assert !user.valid?

    user.full_name = "Test User"
    assert user.valid?
  end

  def test_fields
    user = User.new({:username => "test", :full_name => "Test User"})
    assert_equal user.username, "test"
    assert_equal user.full_name, "Test User"
  end

  def test_group_membership
    groupie = users(:groupie) #Member of one group
    patron = users(:patron) #Member of two groups
    regular = users(:regular) #Member of 0 groups

    cool_kids = groups(:cool_kids) #Has 2 members
    patroons = groups(:patroons) #Has 1 member

    #Test associations
    assert groupie.groups.include?(cool_kids)
    assert !groupie.groups.include?(patroons)
    assert patron.groups.include?(groups(:patroons))
    assert patron.groups.include?(groups(:cool_kids))
    assert_equal regular.groups, []

    #Test in a group method
    assert groupie.in_group?(cool_kids)
    assert !groupie.in_group?(patroons)
    assert !regular.in_group?(cool_kids)

    #Test in_one_group method
    assert groupie.in_one_group
    assert patron.in_one_group
    assert !regular.in_one_group
  end

end
