class AddIndexToRevisions < ActiveRecord::Migration
  def self.up
    add_index :revisions, :position, {:name => "position_index"}
  end

  def self.down
    remove_index :revisions, :position_index
  end
end
