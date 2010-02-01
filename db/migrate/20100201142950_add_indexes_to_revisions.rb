class AddIndexesToRevisions < ActiveRecord::Migration
  def self.up
    add_index :revisions, :document_id, {:name => "document_id_index"}
    add_index :revisions, :user_id, {:name => "user_id_index"}
    add_index :revisions, :position, {:name => "position_index"}
  end

  def self.down
    remove_index :revisions, :document_id_index
    remove_index :revisions, :user_id_index
    remove_index :revisions, :position_index
  end
end
