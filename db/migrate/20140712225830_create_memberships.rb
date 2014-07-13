class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|

      t.timestamps
    end
  end
end
