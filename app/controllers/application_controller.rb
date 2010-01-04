# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  #Boilerplate methods, should be overridden by your authentication system.
  def current_user
    nil
  end
  
  def logged_in?
    true
  end
  
  def admin_logged_in?
    true
  end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
