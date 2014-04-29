class AddIndexToUsers < ActiveRecord::Migration
  def self.up
    add_index :users, :username, {:name => "users_username_index", :unique => true}
  end

  def self.down
    remove_index :users, :users_username_index
  end
end
