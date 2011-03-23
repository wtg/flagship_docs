class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string :title
      t.text :description
      t.boolean :is_private, :default => false
      t.boolean :is_writable, :default => false
      t.integer :download_count, :default => 0
      t.references :category

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
