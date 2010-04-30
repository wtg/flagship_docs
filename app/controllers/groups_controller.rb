class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.xml
  def index
    if !admin_logged_in?
      flash[:error] = "Sorry, the page you requested in unavailable."
      redirect_back
    else
      @groups = Group.all
      @groups.delete_if {|x| !x.allowed_to_read}
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @groups }
      end
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = Group.find(params[:id])
    if @group.allowed_to_read
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @group }
      end
    else
      flash[:error] = "Sorry, the page you requested in unavailable."
      redirect_back
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    if Group.allowed_to_create
      @group = Group.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @group }
      end
    else
      flash[:error] = "Sorry, the page you requested in unavailable."
      redirect_back
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
    if !@group.allowed_to_save
      flash[:error] = "Sorry, the page you requested in unavailable."
      redirect_back
    end
  end

  # POST /groups
  # POST /groups.xml
  def create
    if !Group.allowed_to_create
      flash[:error] = "Sorry, the page you requested in unavailable."
      redirect_back
    else
      @group = Group.new(params[:group])

      respond_to do |format|
        if @group.save
          flash[:notice] = 'Group was successfully created.'
          format.html { redirect_to(@group) }
          format.xml  { render :xml => @group, :status => :created, :location => @group }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
        end
     end
   end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = Group.find(params[:id])
    if !@group.allowed_to_save
      flash[:error] = "Sorry, the page you requested in unavailable."
      redirect_back
    else
      respond_to do |format|
        if @group.update_attributes(params[:group])
          flash[:notice] = 'Group was successfully updated.'
          format.html { redirect_to(@group) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    if !admin_logged_in?
      flash[:error] = "Sorry, the page you requested in unavailable."
      redirect_back
    else
      @group = Group.find(params[:id])
      @group.destroy

      respond_to do |format|
        format.html { redirect_to(groups_url) }
        format.xml  { head :ok }
      end
    end
  end
end
