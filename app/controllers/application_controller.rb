class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :permitted_categories

  # Add permission methods for documents and categories
  include Permissions

  # Selection of categories the current user can view in the tree navigation
  def permitted_categories
    @permitted_categories = upload_permitted_categories
  end

end