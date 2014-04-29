class AddIndexToGroupUsers < ActiveRecord::Migration
  def self.up
    add_index :groups_users, :group_id, {:name => "groups_users_group_id_index"}
    add_index :groups_users, :user_id, {:name => "groups_users_user_id_index"}
    add_index :groups_users, [:group_id, :user_id], {:name => "groups_users_group_id_user_id_index"}
  end

  def self.down
    remove_index :groups_users, :groups_users_group_id_index
    remove_index :groups_users, :groups_users_user_id_index
    remove_index :groups_users, :groups_users_group_id_user_id_index
  end
end
