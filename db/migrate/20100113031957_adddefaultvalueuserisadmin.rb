class Adddefaultvalueuserisadmin < ActiveRecord::Migration
  def self.up
		change_column :users, :is_admin, :boolean, :default => '0'
  end

  def self.down
		change_column :users, :is_admin, :boolean, :default => nil
  end
end
