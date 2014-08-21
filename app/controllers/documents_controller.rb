class DocumentsController < ApplicationController

  def show 
    # Get all the categories our user can submit documents to
    @permitted_categories = upload_permitted_categories
    
    @document = Document.find_by_id(params[:id])
    @revisions = @document.revisions
    @category = Category.find(@document.category_id)
    @children_categories = @category.children
  end

  def download
    # Get all the categories our user can submit documents to
    @permitted_categories = upload_permitted_categories

    @document = Document.find_by_id(params[:id])
    if !@document.nil?
      # Get the most recent revision when downloading a document
      @document = @document.current_revision
      # Increment download count
      @document.increment!(:download_count)
      # Send file binary data to user's browser
      send_data(@document.file_data, :type => @document.file_type, :filename => @document.file_name, :disposition => "inline")
    else
      flash[:error] = "Could not find requested document"
      redirect_to root_path
    end
  end

  def create
    # Create our new document
    @document = Document.new(document_params)
    @document.user_id = current_user.id

    category = Category.find_by_id(@document.category_id)
    if !@document.save
      flash[:error] = "Unable to upload document"
    else
      # Create the initial revision of the new document
      @revision = Revision.new(file_name: revision_params.original_filename,
          file_type: revision_params.content_type,
          file_data: revision_params.read,
          document_id: @document.id,
          user_id: current_user.id,
          position: 0
        )
      if !@revision.save
        @document.destroy
        flash[:error] = "Unable to upload revision"
      else
        # Extract text from file to provide search engine with searchable content
        @revision.extract_text
        @revision.save
      end
    end

    if !category.nil?
      redirect_to category_path(category, view_style: params[:view_style])
    else
      redirect_to root_path
    end
  end

  def search
    # Use Sunspot Solr to search for documents based on the search query
    begin
      @documents = Document.search do
        fulltext params[:query], highlight: true
      end
    rescue
      @documents ||= nil
    end
  end

  private
    def document_params
      params.require(:document).permit(:title, :description, 
        :category_id, :is_writeable, :is_private)
    end

    def revision_params
      params[:document][:revision][:file]
    end
end