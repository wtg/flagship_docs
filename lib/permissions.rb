module Permissions
  # Return the current logged in user
  def current_user
    @current_user = User.find_by_id(session[:user_id])
  end

	# Check if the current user can upload documents to the specified category
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

  # Check if the current user can view the current category
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

  # Check if the current user can upload documents to the specified category
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