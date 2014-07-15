class CategoriesController < ApplicationController

  # GET /categories
  def index
    @categories = Category.roots
  end

  def show
    @category = Category.find params[:id]
    @subcategories = @category.children
    @documents = Document.where(category_id: @category.id).each_slice(5).to_a

    respond_to do |format|
      format.html {}
    end
  end

  def new
    @category = Category.new
    @categories = Category.all.map {|cat| [cat.name, cat.id]}
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      redirect_to "/"
    end
  end   

  private
    def category_params
      params.require(:category).permit(:name, :description, 
        :group_id, :parent_id, :is_featured, :is_private, :is_writable)
    end 

end