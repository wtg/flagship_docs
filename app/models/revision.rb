class Revision < ActiveRecord::Base
  belongs_to :document

  # Handles the file attachment stuff
  # git://github.com/bamnet/attachable.git
  attachable

  scope :current, order("created_at DESC").limit(1)

  # Validations
  # A revision must have a file
  validates :file_name, :presence => true
  validates :file_type, :presence => true
  validates :file_size, :numericality => { :only_integer => true }
  validates_associated :document

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

  # Extract text from the file by.
  # Write the file to a tempfile, run the extractor,
  # and cleanup the tempfile.
  def extract_text
    tempfile = Tempfile.new(file_name)
    tempfile.write(file_contents)
    tempfile.close # If you don't close the file it might still be empty before the next command executes
    begin
      extracted = Textractor.text_from_path(tempfile.path, :content_type => file_type)
    rescue
      logger.error("Unable to extract text from revision #{id} - #{filename}")
      extracted = nil
    end
    tempfile.unlink
    # Redundant line breaks are useless to us.
    extracted.gsub(/(\r?\n)+/,"\n") unless extracted.nil?
  end

  # Update the search_text attributes
  # by running extract_text.  Will not set the
  # value if there is no data (i.e won't write blank).
  def update_search_text
    output = extract_text    
    output.blank? ? false : update_attributes(:search_text => output)
  end
end
