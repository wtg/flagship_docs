class AddUsersToDocsAndRevs < ActiveRecord::Migration
  def change
    add_column :documents, :user_id, :integer
    add_column :revisions, :user_id, :integer
  end
end
