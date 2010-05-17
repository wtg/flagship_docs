class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    if !admin_logged_in?
      flash[:error] = "Sorry, the page you requested in unavailable."
      redirect_back
    else
      @users = User.all
      @users.delete_if {|x| !x.allowed_to_read}
      if @users.empty?
        flash[:error] = "Sorry, the page you requested in unavailable."
        redirect_back
      else
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @users }
        end
      end
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find_by_username(params[:id])
    if @user.allowed_to_read
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @user }
      end
    else
      flash[:error] = "Sorry, the page you requested in unavailable."
      redirect_back
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    if admin_logged_in?
      @user = User.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @user }
      end
    else
      flash[:error] = "Sorry, the page you requested in unavailable."
      redirect_back
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find_by_username(params[:id])
    if !@user.allowed_to_save
      flash[:error] = "Sorry, the page you requested in unavailable."
      redirect_back
    end
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find_by_username(params[:id])
	if !@user.allowed_to_save
	  flash[:error] = "Sorry, the page you requested in unavailable."
      redirect_back
	else
      respond_to do |format|
        if @user.update_attributes(params[:user])
          flash[:notice] = 'User was successfully updated.'
          format.html { redirect_to(@user) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find_by_username(params[:id])
	if !@user.allowed_to_save
	  flash[:error] = "Sorry, the page you requested in unavailable."
      redirect_back
	else
      @user.destroy

      respond_to do |format|
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      end
    end
  end

  # POST /users/bulkadd
  # GET /users/bulkadd
  def bulkadd
    if !admin_logged_in?
      flash[:error] = "Sorry, the page you requested in unavailable."
      redirect_back
    else
      @users = Array.new
      @errors = Array.new
      if !params[:csv_data].blank?
        require 'csv'
        CSV.parse(params[:csv_data]).each do |row|
          if !row[0].blank? && !row[1].blank?
            user = User.new({:username => row[0].strip, :full_name => row[1].strip})
            user.save
            @users.push(user)
          else
            logger.debug("Problem with #{row.join(',')}.")
          end
        end
      end
    end
  end
end
