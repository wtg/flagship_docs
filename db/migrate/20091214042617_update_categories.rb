class UpdateCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :pictures_count, :integer
  end

  def self.down
    remove_column :categories, :pictures_count
  end
end
