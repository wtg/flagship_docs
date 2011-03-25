class CreateRevisions < ActiveRecord::Migration
  def self.up
    create_table :revisions do |t|
      t.references :document
      t.text :search_text
      t.integer :download_count, :default => 0
      t.string :file_name
      t.string :file_type
      t.integer :file_size
      t.binary :file_data, :limit => 4.megabytes

      t.timestamps
    end

    remove_column :documents, :download_count
  end

  def self.down
    drop_table :revisions
    add_column :documents, :download_count, :integer, :default => 0
  end
end
