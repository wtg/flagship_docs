class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.boolean :is_private, :default => false
      t.boolean :is_writable, :default => false
      t.references :parent

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
