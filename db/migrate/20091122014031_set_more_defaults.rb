class SetMoreDefaults < ActiveRecord::Migration
  def self.up
    change_column :documents, :writable, :boolean, :default => false
    change_column :categories, :private, :boolean, :default => false
    change_column :categories, :writable, :boolean, :default => false
  end

  def self.down
    change_column :documents, :writable, :boolean
    change_column :categories, :private, :boolean
    change_column :categories, :writable, :boolean
  end
end
