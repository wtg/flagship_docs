class AddIndexToCategories < ActiveRecord::Migration
  def self.up
    add_index :categories, :name, {:name => "categories_name_index"}
  end

  def self.down
    remove_index :categories, :categories_name_index
  end
end
