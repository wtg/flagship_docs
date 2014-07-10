class CreateGroupsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :groups_users, id: false do |t|
      
      t.timestamps
    end
  end
end
