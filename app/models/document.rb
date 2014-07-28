class Document < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  has_many :revisions, dependent: :destroy

  def current_revision
    Revision.where(document_id: id).order("created_at desc").last
  end

  def cr_download_count
    current_revision.last.download_count
  end

  def self.latest_docs
    latest = Revision.all.order("updated_at desc").to_a.reject { |rev| rev.document.is_private == true }
    latest = latest[0..7]
  end

end
