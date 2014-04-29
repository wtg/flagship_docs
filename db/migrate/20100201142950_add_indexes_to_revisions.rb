class AddIndexesToRevisions < ActiveRecord::Migration
  def self.up
    add_index :revisions, :document_id, {:name => "revisions_document_id_index"}
    add_index :revisions, :user_id, {:name => "revisions_user_id_index"}
  end

  def self.down
    remove_index :revisions, :revisions_document_id_index
    remove_index :revisions, :revisions_user_id_index
  end
end
