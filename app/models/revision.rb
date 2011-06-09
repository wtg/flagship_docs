class Revision < ActiveRecord::Base
  before_create :set_text

  acts_as_list :scope => :document

  has_attached_file :upload, :storage => :database

  default_scope select_without_file_columns_for(:upload).merge({:order => 'position DESC'})

  #Validation
  validates_presence_of :user_id#, :document_id
  validates_attachment_presence :upload


  #Relationships
  belongs_to :document
  belongs_to :user

  #Test if this revision is the current one
  def current?
    return document.current_revision.id == self.id
  end

  #Try and identify the type of file uploaded
  #other will be returned if the type doesn't match something we recognize
  def type
    result = case self.upload_content_type
      #PDF files
      when "application/pdf" then "pdf"
      #Word and Word 2007 files
      when "application/msword" then "doc"
      when "application/vnd.openxmlformats-officedocument.wordprocessingml.document" then "doc"
      #Excel and Excel 2007 files
      when "application/vnd.ms-excel" then "xls"
      when "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" then "xls"
      #Powerpoint and Powerpoint 2007 files
      when "application/vnd.ms-powerpoint" then "ppt"
      when "application/vnd.openxmlformats-officedocument.presentationml.presentation" then "ppt"
      #Open Document Document
      when "application/vnd.oasis.opendocument.text" then "odt"
      #Open Document Presentation
      when "application/vnd.oasis.opendocument.presentation" then "odp"
      #Open Document Spreadsheet
      when "application/vnd.oasis.opendocument.spreadsheet" then "ods"
      else "other"
    end
    result
  end

  # Attempt to extract text from a document.
  # TODO: Refactor this into a library module/class/something else.
  # We should not be maintaining this in a test-less model.
  def text
    tempfile = Tempfile.new(self.upload_file_name)
    tempfile.write(self.upload.file_contents)
    tempfile.close #If you don't close the file it might still be
    #empty before the next command executes

    begin
      result = Textract.text_from_path(tempfile.path)
      result.gsub!(tempfile.path, "")
    rescue Textractor::UnknownContentType
      result = ""
    end
    result
  ensure
    tempfile.unlink
  end

  # Set the search_text field to the extracted text from a revision
  def set_text
    self.search_text = text
  end

  #Authenticates Access
  has_owner :user
  autosets_owner_on_create

end
