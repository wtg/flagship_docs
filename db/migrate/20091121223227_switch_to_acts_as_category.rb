class SwitchToActsAsCategory < ActiveRecord::Migration
  def self.up
    remove_column :categories, :lft
    remove_column :categories, :rgt

    add_column :categories, :children_count, :integer
    add_column :categories, :ancestors_count, :integer
    add_column :categories, :descendants_count, :integer
  end

  def self.down
    add_column :categories, :lft, :integer
    add_column :categories, :rgt, :integer

    remove_column :categories, :children_count
    remove_column :categories, :ancestors_count
    remove_column :categories, :descendants_count
  end
end
