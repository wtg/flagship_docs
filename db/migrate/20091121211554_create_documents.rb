class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string :title
      t.text :description
      t.boolean :readable
      t.boolean :writable
      t.integer :downloaded
      t.references :category
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
