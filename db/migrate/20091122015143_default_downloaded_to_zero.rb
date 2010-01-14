class DefaultDownloadedToZero < ActiveRecord::Migration
  def self.up
    change_column :documents, :downloaded, :integer, :default => 0
  end

  def self.down
    change_column :documents, :downloaded, :integer
  end
end
