class AddIndexesToCategories < ActiveRecord::Migration
  def self.up
    add_index :categories, :parent_id, {:name => "parent_id_index"}
    add_index :categories, :group_id, {:name => "group_id_index"}
    add_index :categories, :user_id, {:name => "user_id_index"}
    add_index :categories, :background_id, {:name => "background_id_index"}
  end

  def self.down
    remove_index :categories, :parent_id_index
    remove_index :categories, :group_id_index
    remove_index :categories, :user_id_index
    remove_index :categories, :background_id_index
  end
end
