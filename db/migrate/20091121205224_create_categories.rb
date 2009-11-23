class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.boolean :readable
      t.boolean :writable
      t.integer :parent_id
      t.references :group
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
