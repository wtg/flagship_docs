class Revision < ActiveRecord::Base
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

  def text
    tempfile = Tempfile.new(self.upload_file_name)
    tempfile.write(self.upload.file_contents)
    #find out what kinda file we're dealing with and run appropriate system calls
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

  def rev_text
    #Current Revision Text 
    #create temporary files for use during indexing
    tempfile = Tempfile.new(self.upload_file_name)
    tempfile.write (self.upload.file_contents)
    #If it's a docx,xlsx, or pptx, fix the zip archive (paperclip bungles it up)
    if self.upload_content_type == ("application/vnd.openxmlformats-officedocument.wordprocessingml.document" or "application/vnd.openxmlformats-officedocument.presentationml.presentation" or "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
      system("yes | zip -FF #{tempfile.path} --out /tmp/doc")
    end
    #find what kind of file we're dealing with and run appropriate system calls
    result = case self.upload_content_type
      when "text/plain" then `cat #{tempfile.path}`
      when "application/pdf" then `pdftotext #{tempfile.path} -`
      when "application/msword" then `catdoc -w #{tempfile.path}`
      when "application/vnd.ms-excel" then `xls2cvs #{tempfile.path}`
      when "application/vnd.ms-powerpoint" then `catppt #{tempfile.path}`
      when "application/vnd.openxmlformats-officedocument.wordprocessingml.document" then `doctotext "/tmp/doc.docx"`
      when "application/vnd.openxmlformats-officedocument.presentationml.presentation" then `doctotext "/tmp/doc.docx"`
      when "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" then `doctotext "/tmp/doc.docx"`
      when "image/jpeg" then `jhead -c #{tempfile.path}`
      when "image/png"  then `jhead -c #{tempfile.path}`
      when "application/vnd.oasis.opendocument.text" then `odt2txt #{tempfile.path}`
      when "application/vnd.oasis.opendocument.presentation" then `odt2txt #{tempfile.path}`
      when "application/vnd.oasis.opendocument.spreadsheet" then `odt2txt #{tempfile.path}`
      else ""
    end

    result.gsub!(tempfile.path,"")
    #remove the temporary file we made when fixing zipped documents
    system('rm -rf "/tmp/doc"')
    #save the data
    document = Document.find(self.document_id)
    document.current_revision_text = result
    document.save
  end

  #Authenticates Access
  has_owner :user
  autosets_owner_on_create

end
