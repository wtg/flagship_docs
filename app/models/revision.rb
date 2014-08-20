class Revision < ActiveRecord::Base

  belongs_to :document
  belongs_to :user

  validates :file_name, presence: true
  validates :file_type, presence: true
  
  def extension_type
    ext = case file_type
      # PDF Files
      when "application/pdf" then "pdf"
      when "application/msword" then "doc"
      when "application/vnd.oasis.opendocument.text" then "odt"
      else "other"
    end
    ext
  end

  def self.extract_text

  end

end
