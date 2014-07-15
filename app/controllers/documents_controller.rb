class DocumentsController < ApplicationController

  def show 
    @document = Document.find_by_id(params[:id])
    if !@document.nil?
      @document = @document.current_revision.last
      send_data(@document.file_data, :type => @document.file_type, :filename => @document.file_name, :disposition => "inline")
    else
      flash[:error] = "Could not find document"
      redirect_to root_path
    end
  end

  def create
    @document = Document.new(document_params)

    category = Category.find_by_id(@document.category_id)
    if !@document.save
      flash[:error] = "Unable to upload document"
    else
      # Create the initial revision of the new document
      @revision = Revision.new(file_name: revision_params.original_filename,
          file_type: revision_params.content_type,
          file_data: revision_params.read,
          document_id: @document.id,
          position: 0
        )
      if !@revision.save
        flash[:error] = "Unable to upload revision"
      end
    end

    if !category.nil?
      redirect_to category_path(category)
    else
      redirect_to root_path
    end
  end

  private
    def document_params
      params.require(:document).permit(:title, :description, 
        :category_id, :is_writeable, :is_private, :category_id)
    end

    def revision_params
      params[:document][:revision][:file]
    end
end