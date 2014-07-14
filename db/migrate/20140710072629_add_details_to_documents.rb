class AddDetailsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :title, :string
    add_column :documents, :description, :text
    add_column :documents, :is_private, :boolean, default: true
    add_column :documents, :is_writable, :boolean, default: false
    add_column :documents, :category_id, :integer
    add_column :documents, :user_id, :integer
  end
end
