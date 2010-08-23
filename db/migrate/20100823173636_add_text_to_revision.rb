class AddTextToRevision < ActiveRecord::Migration
  def self.up
    add_column :revisions, :search_text, :text
  end

  def self.down
    remove_column :revisions, :search_text
  end
end
