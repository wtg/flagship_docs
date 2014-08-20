class Document < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  has_many :revisions, dependent: :destroy

  def current_revision
    Revision.where(document_id: id).order("position asc").first
  end

  def total_downloads
    count = 0
    revisions.each {|rev| count += rev.download_count}
    return count
  end

  def self.latest_docs
    latest = Revision.all.order("updated_at desc").to_a.reject { |rev| rev.document.is_private == true }
    latest = latest[0..7]
  end

end
