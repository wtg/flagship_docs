class UseAwsomeNestedSetForCategories < ActiveRecord::Migration
  def self.up
   add_column :categories, :lft, :integer
   add_column :categories, :rgt, :integer
  end

  def self.down
    remove_column :categories, :lft
    remove_column :categories, :rgt
  end
end
