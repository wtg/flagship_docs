class AddIndexesToCategories < ActiveRecord::Migration
  def self.up
    add_index :categories, :parent_id, {:name => "categories_parent_id_index"}
    add_index :categories, :user_id, {:name => "categories_user_id_index"}
    add_index :categories, :group_id, {:name => "categories_group_id_index"}
    add_index :categories, :background_id, {:name => "categories_background_id_index"}
  end

  def self.down
    remove_index :categories, :categories_parent_id_index
    remove_index :categories, :categories_user_id_index
    remove_index :categories, :categories_group_id_index
    remove_index :categories, :categories_background_id_index
  end
end
