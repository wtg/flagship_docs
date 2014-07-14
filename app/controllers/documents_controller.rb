class DocumentsController < ApplicationController

  def create
    @document = Document.new(document_params)

    category = Category.find_by_id(@document.category_id)
    if !@document.save
      flash[:error] = "Unable to upload document :("
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
end
