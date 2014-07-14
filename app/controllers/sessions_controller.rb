class SessionsController < ApplicationController

  def new
    cas_hash = request.env["omniauth.auth"]

    if User.find_by_username(cas_hash[:uid]).nil?
      user = User.new(username: cas_hash[:uid], email: cas_hash[:uid] + "@rpi.edu", is_admin: 0, full_name: cas_hash[:uid])
      user.save
      session[:user_id] = user.id
      redirect_to "/"
    else
      user = User.find_by_username(cas_hash[:uid])
      flash[:notice] = "You have successfully logged in."
      session[:user_id] = user.id
      redirect_to "/"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end
end
