class RemovePositionFromCategories < ActiveRecord::Migration
  def self.up
    remove_column :categories, :position
  end

  def self.down
    add_column :categories, :position, :integer
  end
end
