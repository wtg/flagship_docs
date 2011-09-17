class Document < ActiveRecord::Base
  belongs_to :category
  has_many :revisions, :dependent => :destroy

  accepts_nested_attributes_for :revisions

  searchable do
    text :title, :default_boost => 2, :stored => true
    text :description, :stored => true
    text :search_texts, :stored => true do
      revisions.map { |revision| revision.search_text }
    end
  end

  def download_count
    revisions.sum(:download_count)
  end
end
