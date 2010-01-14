class AddPositionToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :position, :integer
  end

  def self.down
    remove_column :categories, :position
  end
end
