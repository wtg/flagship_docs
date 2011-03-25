class Document < ActiveRecord::Base
  belongs_to :category
  has_many :revisions, :dependent => :destroy

  accepts_nested_attributes_for :revisions

  def download_count
    revisions.sum(:download_count)
  end
end
