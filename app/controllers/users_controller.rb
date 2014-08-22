class UsersController < ApplicationController

  before_filter :admin?, except: [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id params[:id]
  end

  def destroy
    if @user = User.find_by_id(params[:id])
      @user.destroy
    end
    redirect_to users_path
  end

  def admin_status
    @user = User.find_by_id(params[:id])
    if @user 
      if !@user.is_admin?
        @user.is_admin = true
      else
        @user.is_admin = false
      end
      @user.save
      redirect_to users_path
    end
  end

end
