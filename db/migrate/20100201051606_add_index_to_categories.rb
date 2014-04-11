class AddIndexToCategories < ActiveRecord::Migration
  def self.up
    add_index :categories, :name, {:name => "name_index"}
  end

  def self.down
    remove_index :categories, :name_index
  end
end
