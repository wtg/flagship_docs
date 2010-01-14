class RenameRevisionPosIdToPos < ActiveRecord::Migration
  def self.up
    rename_column :revisions, :position_id, :position
  end

  def self.down
    rename_column :revisions, :position, :position_id
  end
end
