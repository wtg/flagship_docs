class Revision < ActiveRecord::Base

  belongs_to :document
  belongs_to :user

  validates_presence_of :file_name, :file_type, :file_data

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

  def extract_text
    # Create a temporary file to read from 
    tempfile = Tempfile.new(file_name, :encoding => 'ascii-8bit')
    tempfile.write(file_data)
    tempfile.close

    # Try extracting the contents of the file depending on the content type
    begin
      contents = Textractor.text_from_path(tempfile.path, :content_type => file_type)
    rescue
      logger.error("Unable to extract text from file. Revision id = #{id}, File name = #{filename}")
      contents = nil
    end
    tempfile.unlink

    # Redundant line breaks are useless to us
    self.search_text = contents.gsub(/(\r?\n)+/,"\n") if !contents.blank?
  end

end
