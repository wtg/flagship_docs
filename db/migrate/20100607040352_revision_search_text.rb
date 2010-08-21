class RevisionSearchText < ActiveRecord::Migration
  def self.up
    add_column :documents, :current_revision_text, :text, :default => ""
  end

  def self.down
    remove_column :current_revisions_text
  end
end
