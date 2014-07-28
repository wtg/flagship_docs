class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :can_upload_documents

  def can_upload_documents(category)
    if !current_user.nil?
      if category.nil?
        # User will specify category upon uploading
        return true
      elsif category.is_writable or current_user.member_of(category.group_id)
        # Category can be submitted to or user is part of controlling group
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def category_viewable?(category)
    # Check if user is able to view a specific category
    if !current_user.nil?
      if current_user.is_admin? or current_user.member_of(category.group_id)
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def current_user
    # Return the current logged in user
    @current_user = User.find_by_id(session[:user_id])
  end

  def upload_permitted_categories
    # Return all categories the current user can upload to
    if !current_user.nil?
      if current_user.is_admin?
        # current user is an admin and can upload to any category
        return Category.all
      else
        return current_user.writable_categories 
      end
    else
      # user is not logged in, they can't upload anything
      return nil
    end
  end

end
