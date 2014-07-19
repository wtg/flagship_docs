class CategoriesController < ApplicationController

  # GET /categories
  def index
    @categories = Category.roots
    @featured = Category.featured
    @latest_docs = Document.latest_docs
  end

  def manage
    @categories = Category.all
  end 

  def show
    @category = Category.find params[:id]
    @subcategories = @category.children
    @documents = Document.where(category_id: @category.id).order("updated_at desc").page(params[:page])
    
    # Check if a view style (list or grid) is specified
    if params.key?(:view_style) 
      @view_style = params[:view_style]
    else
      # Default to list view
      @view_style = "grid"
    end

    respond_to do |format|
      format.html {}
    end
  end

  def new
    @category = Category.new
    # Get categories and groups for selection dropdowns
    @categories = Category.all.map {|cat| [cat.name, cat.id]}
    @groups = Group.all.map {|group| [group.name, group.id]}
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      redirect_to "/"
    end
  end  

  def edit
    @category = Category.find_by_id(params[:id])
    # Get categories and groups for selection dropdowns
    @categories = Category.all.map {|cat| [cat.name, cat.id]}
    @categories.delete([@category.name, @category.id])
    @groups = Group.all.map {|group| [group.name, group.id]}
  end

  def update
    @category = Category.find_by_id(params[:id])
    @category.update_attributes(category_params)
    redirect_to edit_category_path(@category)
  end

  def destroy
    @category = Category.find_by_id(params[:id]).destroy
    redirect_to manage_categories_path
  end

  private
    def category_params
      params.require(:category).permit(:name, :description, 
        :group_id, :parent_id, :is_featured, :is_private, :is_writable)
    end 

end