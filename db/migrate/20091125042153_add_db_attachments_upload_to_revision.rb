class AddDbAttachmentsUploadToRevision < ActiveRecord::Migration
  def self.up
    add_column :revisions, :upload_file_name, :string
    add_column :revisions, :upload_content_type, :string
    add_column :revisions, :upload_file_size, :integer
    add_column :revisions, :upload_updated_at, :datetime
    if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "mysql"
      execute "ALTER TABLE revisions ADD COLUMN upload_file LONGBLOB"
    else
      add_column :revisions, :upload_file, :binary
    end
  end

  def self.down
    remove_column :revisions, :upload_file_name
    remove_column :revisions, :upload_content_type
    remove_column :revisions, :upload_file_size
    remove_column :revisions, :upload_updated_at
    if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "mysql"
      execute "ALTER TABLE revisions DROP upload_file"
    else
      remove_column :revisions, :upload_file
    end
  end
end
