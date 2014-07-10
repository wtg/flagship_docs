class AddDetailsToRevisions < ActiveRecord::Migration
  def change
    add_column :revisions, :document_id, :integer
    add_column :revisions, :user_id, :integer
    add_column :revisions, :position, :integer
    add_column :revisions, :upload_file_name, :string
    add_column :revisions, :upload_content_type, :string
    add_column :revisions, :upload_file_size, :integer
    add_column :revisions, :upload_updated_at, :datetime
    add_column :revisions, :upload_file, :binary, limit: 2147483647
    add_column :revisions, :search_text, :text
  end
end
