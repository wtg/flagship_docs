class AddBackgroundToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :background_id, :integer
  end

  def self.down
    remove_column :categories, :background_id
  end
end
