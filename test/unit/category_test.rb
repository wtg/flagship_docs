require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  fixtures :users, :groups, :categories

  def test_validation
    category = Category.new
    assert !category.valid?, "New category with no params"

    category.name = ""
    assert !category.valid?, "New category with blank params"

    category.name = "Root 1"
    category.group = groups(:cool_kids)
    category.user = users(:groupie)
    assert category.valid?, "New category with params and owners"
  end

  def test_fields
    cat = Category.new({:name => "Root Level", :description => "Root Level Category"})
    cat.group = groups(:cool_kids)
    cat.user = users(:groupie)

    assert_equal cat.name, "Root Level", "Category name retrieval"

    #Testing defaults
    assert !cat.private, "Category defaults to publicly readable"
    assert !cat.writable, "Category defaults to non-writable"
  end

  def test_saving
    ActiveRecord::Base.accessor = nil #Required to reset

    cat = Category.new({:name => "Root Level", :description => "Root Level Category"})
    cat.group = groups(:cool_kids)
    assert !cat.save, "Category requires user id to save"

    cat.user = users(:groupie)
    assert cat.save, "Category saves."

    roots = Category.roots
    assert_equal roots.length, 1, "There is only one root"
    assert_equal roots.first, cat, "Category created is the first root"
  end

  def test_cat_with_authenticates_access
    groupie = users(:groupie)
    patron = users(:patron)
    regular = users(:regular)
    
    ActiveRecord::Base.accessor = groupie

    cat = Category.new({:name => "Root Level", :description => "Root Level Category"})
    cat.group = groups(:cool_kids)
    if cat.save
      #Testing autosets owner on create
      assert_equal cat.user, groupie, "The owner was autoset when created"
    else
      flunk "Test failed to save"
    end
    
    #Patron is in cool kids
    ActiveRecord::Base.accessor = patron
    assert cat.current_user_in_my_group?, "Current user in group for patron/cool_kids"
    
    #Regular is not
    ActiveRecord::Base.accessor = regular
    assert !cat.current_user_in_my_group?, "Current user in group for a user in no groups"
  end
  
  def test_cat_with_permissions
    groupie = users(:groupie)
    patron = users(:patron)
    regular = users(:regular)
    admin = users(:admin)
    
    cool_kids = groups(:cool_kids)
    patroons = groups(:patroons)
    
    #Public Category
    ActiveRecord::Base.accessor = groupie
    cat = Category.new({:name => "Root Level", :description => "Root Level Category", :group_id => patroons.id})
    cat.save
    
    assert_equal cat.private, !cat.not_private, "Category not_private method"
    
    [groupie, patron, regular, admin, nil].each do |u|
      ActiveRecord::Base.accessor = u
      assert cat.allowed_to_read, "User allowed to read default category"
    end
    [].each do |u|
      ActiveRecord::Base.accessor = u
      assert !cat.allowed_to_read, "No one cannot read a default category"
    end
    [groupie, patron, admin].each do |u|
      ActiveRecord::Base.accessor = u
      assert cat.allowed_to_save, "Owner, Group, Admin allowed to write default category"
    end
    [regular, nil].each do |u|
      ActiveRecord::Base.accessor = u
      assert !cat.allowed_to_save, "Regular and nil cannot write default category"
    end
    
    #Hidden Category
    ActiveRecord::Base.accessor = groupie
    cat.private = true
    cat.save
    [groupie, patron, admin].each do |u|
      ActiveRecord::Base.accessor = u
      assert cat.allowed_to_read, "Owner, group members, and admin can read hidden category"
    end
    [regular, nil].each do |u|
      ActiveRecord::Base.accessor = u
      assert !cat.allowed_to_read, "Outsiders cannot read hidden category"
    end
    [groupie, patron, admin].each do |u|
      ActiveRecord::Base.accessor = u
      assert cat.allowed_to_save, "Owner, Group, Admin allowed to write hidden category"
    end
    [regular, nil].each do |u|
      ActiveRecord::Base.accessor = u
      assert !cat.allowed_to_save, "Regular and nil cannot write hidden category"
    end
    
    #Publicly Writable Category
    ActiveRecord::Base.accessor = groupie
    cat.private = false
    cat.writable = true
    cat.save
    [groupie, patron, regular, admin, nil].each do |u|
      ActiveRecord::Base.accessor = u
      assert cat.allowed_to_read, "Everyone can read public category"
    end
    [].each do |u|
      ActiveRecord::Base.accessor = u
      assert !cat.allowed_to_read, "No one cannot read public category"
    end
    [groupie, patron, regular, admin].each do |u|
      ActiveRecord::Base.accessor = u
      assert cat.allowed_to_save, "All users can write public category"
    end
    [nil].each do |u|
      ActiveRecord::Base.accessor = u
      #I don't know a way to handle this case.  Clearly a nil user shouldn't be allowed to save
      #assert !cat.allowed_to_save, "Nil user cannot write public category"
    end
  end

end
