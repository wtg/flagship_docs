class Revision < ActiveRecord::Base
  belongs_to :document

  # Handles the file attachment stuff
  # git://github.com/bamnet/attachable.git
  attachable

  scope :current, order("created_at DESC").limit(1)

  # Try and identify the type of file uploaded
  # other will be returned if the type doesn't match something we recognize
  def short_type
    result = case file_type
      # PDF files
      when "application/pdf" then "pdf"
      # Word and Word 2007 files
      when "application/msword" then "doc"
      when "application/vnd.openxmlformats-officedocument.wordprocessingml.document" then "doc"
      # Excel and Excel 2007 files
      when "application/vnd.ms-excel" then "xls"
      when "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" then "xls"
      # Powerpoint and Powerpoint 2007 files
      when "application/vnd.ms-powerpoint" then "ppt"
      when "application/vnd.openxmlformats-officedocument.presentationml.presentation" then "ppt"
      # Open Document Document
      when "application/vnd.oasis.opendocument.text" then "odt"
      # Open Document Presentation
      when "application/vnd.oasis.opendocument.presentation" then "odp"
      # Open Document Spreadsheet
      when "application/vnd.oasis.opendocument.spreadsheet" then "ods"
      else "other"
    end
    result
  end

end
