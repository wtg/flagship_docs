class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :group_id
      t.integer :user_id
      t.integer :level

      t.timestamps
    end
  end
end
