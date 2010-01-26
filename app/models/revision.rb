class Revision < ActiveRecord::Base
  acts_as_list :scope => :document

  has_attached_file :upload, :storage => :database
 
  default_scope select_without_file_columns_for(:upload).merge({:order => 'position DESC'})

  #Relationships
  belongs_to :document
  belongs_to :user
	
  #Test if this revision is the current one
  def current?
    return Document.current_revision.id == self.id
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

  def text
    tempfile = Tempfile.new(self.upload_file_name)
    tempfile.write(self.upload.file_contents)
    
    result = case self.upload_content_type
      when "application/msword" then `catdoc -w #{tempfile.path}`
      when "application/pdf" then `pdftotext #{tempfile.path} -`
      when "application/vnd.ms-excel" then `xls2cvs #{tempfile.path}`
      when "application/vnd.ms-powerpoint" then `catppt #{tempfile.path}`
      when "image/jpeg" then `jhead -c #{tempfile.path}`
      when "image/png"  then `jhead -c #{tempfile.path}`
      else ""
    end
    result.gsub(tempfile.path,"")
  end

	has_owner :user
	autosets_owner_on_create

end
