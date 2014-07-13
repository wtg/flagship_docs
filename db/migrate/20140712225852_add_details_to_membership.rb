class AddDetailsToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :group_id, :integer
    add_column :memberships, :user_id, :integer
  end
end
