class DocumentsController < ApplicationController

  def create
    @document = Document.new(document_params)
    @document.save
    redirect_to "/"
  end

  private
    def document_params
      params.require(:document).permit(:title, :description, :category_id)
    end

end
