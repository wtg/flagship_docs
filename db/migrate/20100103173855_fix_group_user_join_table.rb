class FixGroupUserJoinTable < ActiveRecord::Migration
  def self.up
    change_table:groups_users do |t|
      t.references :user
      t.remove :project_id
    end
  end

  def self.down
    change_table:groups_users do |t|
      t.references :project
      t.remove :user_id
    end
  end
end
