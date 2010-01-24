class CreateRevisions < ActiveRecord::Migration
  def self.up
    create_table :revisions do |t|
      t.references :document
      t.references :user
      t.integer :position_id

      t.timestamps
    end
  end

  def self.down
    drop_table :revisions
  end
end
