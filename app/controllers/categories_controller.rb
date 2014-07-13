class CategoriesController < ApplicationController

  # GET /categories
  def index
    @categories = Category.roots
  end

  def show
    @category = Category.find params[:id]
  end

  def new
    @category = Category.new
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
        :group_id, :is_featured, :private)
    end 

end