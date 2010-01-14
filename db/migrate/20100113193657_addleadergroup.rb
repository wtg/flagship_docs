class Addleadergroup < ActiveRecord::Migration
  def self.up
		add_column :groups, :group_leader_id, :integer
  end

  def self.down
		remove_column :groups, :group_leader_id
  end
end
