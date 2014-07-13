class AddLevelToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :level, :integer
  end
end
