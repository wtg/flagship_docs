module Permissions
  # Return the current logged in user
  def current_user
    @current_user = User.find_by_id(session[:user_id])
  end

  # ====================
  # Category Permissions
  # ====================

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
    return nil if current_user.nil?
    permitted_categories = Category.all if current_user.is_admin?
    permitted_categories ||= current_user.writable_categories
  end

  # ====================
  # Document Permissions
  # ====================


  # Check if the current user can revise a specific document
  def can_revise_document(document)
    # deny user if not logged in
    return false if current_user.nil?
    # current user is an admin
    return true if current_user.is_admin?
    # current user is a member of the category's
    #   group for a document that is write protected
    unless document.category.group.nil?
      return true if !document.is_writable? and 
                     (document.category.group.members.include?(current_user) or
                      document.category.group.leaders.include?(current_user))
    end
    return document.is_writable?
  end

  # Check if the current user can view a specific document
  def can_view_document(document)
    # deny access if not logged in
    return false if current_user.nil?
    # allow access if user is logged in
    return true if current_user.is_admin?
    # current user is a member of the category's
    #   group for a document that is private
    unless document.category.group.nil?
      return true if document.is_private? and 
                    (document.category.group.members.include?(current_user) or
                     document.category.group.leaders.include?(current_user))
    end
    return !document.is_private?
  end

  # Check if the current user can edit a specific document
  def can_edit_document(document)
    # deny user if not logged in
    return false if current_user.nil?
    # current user is an admin
    return true if current_user.is_admin?
    # current user is a member of the category's group
    unless document.category.group.nil?
      return true if document.category.group.members.include?(current_user) or 
                     document.category.group.leaders.include?(current_user)
    end
    return false
  end

end