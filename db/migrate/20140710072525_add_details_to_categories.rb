class AddDetailsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :name, :string
    add_column :categories, :description, :text
    add_column :categories, :is_private, :boolean, default: false
    add_column :categories, :is_writable, :boolean, default: false
    add_column :categories, :parent_id, :integer
    add_column :categories, :group_id, :integer
    add_column :categories, :is_featured, :boolean
  end
end
