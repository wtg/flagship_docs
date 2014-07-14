class AddDetailsToRevisions < ActiveRecord::Migration
  def change
    add_column :revisions, :document_id, :integer
    add_column :revisions, :user_id, :integer
    add_column :revisions, :position, :integer
    add_column :revisions, :download_count, :integer, default: 0

    add_column :revisions, :file_name, :string
    add_column :revisions, :file_type, :string
    add_column :revisions, :file_size, :integer
    add_column :revisions, :file_data, :binary, limit: 4194304

    add_column :revisions, :search_text, :text
  end
end
