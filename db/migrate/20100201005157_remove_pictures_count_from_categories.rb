class RemovePicturesCountFromCategories < ActiveRecord::Migration
  def self.up
    remove_column :categories, :pictures_count
  end

  def self.down
    add_column :categories, :pictures_count, :integer
  end
end
