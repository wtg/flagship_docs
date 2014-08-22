class Document < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  has_many :revisions, dependent: :destroy

  validates_presence_of :category

  # Sunspot Solr search configuration for the document object
  searchable do 
    # Give document titles higher weight when determining search results
    text :title, default_boost: 2, stored: true
    text :description, stored: true
    text :revision_search_texts, stored: true do
      revisions.map { |revision| revision.search_text }
    end
  end

  def current_revision
    Revision.where(document_id: id).order("position asc").first
  end

  def total_downloads
    revisions.sum(:download_count)
  end

  def self.latest_docs
    latest = Revision.all.order("updated_at desc").to_a.reject { |rev| rev.document.is_private == true }
    latest = latest[0..7]
  end

end
