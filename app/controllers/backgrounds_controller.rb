class BackgroundsController < ApplicationController
  # GET /backgrounds/new.xml
  def new
    @background = Background.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @background }
    end
  end

  # POST /backgrounds
  # POST /backgrounds.xml
  def create
    @background = Background.new(params[:background])

    respond_to do |format|
      if @background.save
        flash[:notice] = 'Background was successfully created.'
        format.html { redirect_to(@background) }
        format.xml  { render :xml => @background, :status => :created, :location => @background }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @background.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /backgrounds/1
  # PUT /backgrounds/1.xml
  def update
    @background = Background.find(params[:id])

    respond_to do |format|
      if @background.update_attributes(params[:background])
        flash[:notice] = 'Background was successfully updated.'
        format.html { redirect_to(@background) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @background.errors, :status => :unprocessable_entity }
      end
    end
  end
end
