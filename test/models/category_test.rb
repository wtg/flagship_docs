require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  test "should not save category without name" do
    category = Category.new
    assert_not category.save
  end

  test "category with nil parent id should be root" do
    assert categories(:student_senate).nil?
  end 

  test "find all categories that are root" do
    assert_equals 2, Category.roots
  end

  test "find all ancestors for a given category" do
    assert_equals 2, categories(:concerto).ancestors.length
  end

  test "find all descendants for a given category" do
    assert_equals 
  end

end