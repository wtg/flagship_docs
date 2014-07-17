class SessionsController < ApplicationController

  def new
    cas_hash = request.env["omniauth.auth"]

    if User.find_by_username(cas_hash[:uid]).nil?
      user = User.new(username: cas_hash[:uid], email: cas_hash[:uid] + "@rpi.edu", is_admin: 0, full_name: cas_hash[:uid])
      user.save
      session[:user_id] = user.id
      flash[:success] = "Your account has been created. Welcome to Flagship Docs!"
      redirect_to "/"
    else
      user = User.find_by_username(cas_hash[:uid])
      flash[:success] = "You have successfully logged in."
      session[:user_id] = user.id
      redirect_to "/"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:error] = "You've successfully logged out. Come back soon."
    redirect_to "/"
  end
end
