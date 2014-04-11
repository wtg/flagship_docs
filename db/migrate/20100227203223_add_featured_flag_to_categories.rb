class AddFeaturedFlagToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :is_featured, :boolean
  end

  def self.down
    remove_column :categories, :is_featured
  end
end
