class AddDetailsToGroupsUsers < ActiveRecord::Migration
  def change
    add_column :groups_users, :group_id, :integer
    add_column :groups_users, :user_id, :integer
  end
end
