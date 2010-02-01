class AddIndexToUsers < ActiveRecord::Migration
  def self.up
    add_index :users, :username, {:name => "username_index", :unique => true}
  end

  def self.down
    remove_index :users, :username_index
  end
end
