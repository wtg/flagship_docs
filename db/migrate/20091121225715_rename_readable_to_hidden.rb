class RenameReadableToHidden < ActiveRecord::Migration
  def self.up
    rename_column :categories, :readable, :private
  end

  def self.down
    rename_column :categories, :private, :readable
  end
end
