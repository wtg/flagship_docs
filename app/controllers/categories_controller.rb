class CategoriesController < ApplicationController

  # GET /categories
  def index
    @categories = Category.roots
  end

  def show
    @category = Category.find params[:id]
    @subcategories = @category.children
    @documents = Document.where(category_id: @category.id)

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
    @category.user_id = current_user.id
    if @category.save
      redirect_to @category
    else
      redirect_to "/"
    end
  end   

  private
    def category_params
      params.require(:category).permit(:name, :description, 
        :group_id, :parent_id, :is_featured, :private)
    end 

end