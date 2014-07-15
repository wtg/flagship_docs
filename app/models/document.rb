class Document < ActiveRecord::Base

  belongs_to :user
  has_many :revisions, dependent: :destroy

  def current_revision
    Revision.where(document_id: id).order("created_at desc")
  end

end
