class AddDbAttachmentsUploadToRevision < ActiveRecord::Migration
  def self.up
    add_column :revisions, :upload_file_name, :string
    add_column :revisions, :upload_content_type, :string
    add_column :revisions, :upload_file_size, :integer
    add_column :revisions, :upload_updated_at, :datetime
    add_column :revisions, :upload_file, :binary
  end

  def self.down
    remove_column :revisions, :upload_file_name
    remove_column :revisions, :upload_content_type
    remove_column :revisions, :upload_file_size
    remove_column :revisions, :upload_updated_at
    remove_column :revisions, :upload_file
  end
end
