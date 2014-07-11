class CategoriesController < ApplicationController

  # GET /categories
  def index
    @categories = Category.roots
  end

end