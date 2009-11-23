class DefaultDocsToReadable < ActiveRecord::Migration
  def self.up
    change_column :documents, :readable, :boolean, :default => true
  end

  def self.down
    change_column :documents, :readable, :boolean
  end
end
