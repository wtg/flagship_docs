class AddIndexToRevisions < ActiveRecord::Migration
  def self.up
    add_index :revisions, :position, {:name => "revisions_position_index"}
  end

  def self.down
    remove_index :revisions, :revisions_position_index
  end
end
