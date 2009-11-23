class RevisionsController < ApplicationController
  # GET /revisions
  # GET /revisions.xml
  def index
    @revisions = Revision.find(:all, :conditions => {:document_id => params[:document_id]})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @revisions }
    end
  end

  # GET /revisions/1
  # GET /revisions/1.xml
  def show
    @revision = Revision.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @revision }
    end
  end

  # GET /revisions/new
  # GET /revisions/new.xml
  def new
    @revision = Revision.new
    @revision.document_id = params[:document_id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @revision }
    end
  end

  # GET /revisions/1/edit
  def edit
    @revision = Revision.find(params[:id])
  end

  # POST /revisions
  # POST /revisions.xml
  def create
    @revision = Revision.new(params[:revision])
    @revision.document_id = params[:document_id]

    respond_to do |format|
      if @revision.save
        flash[:notice] = 'Revision was successfully created.'
        format.html { redirect_to([@revision.document, @revision]) }
        format.xml  { render :xml => @revision, :status => :created, :location => @revision }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @revision.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /revisions/1
  # PUT /revisions/1.xml
  def update
    @revision = Revision.find(params[:id])

    respond_to do |format|
      if @revision.update_attributes(params[:revision])
        flash[:notice] = 'Revision was successfully updated.'
        format.html { redirect_to(@revision) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @revision.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /revisions/1
  # DELETE /revisions/1.xml
  def destroy
    @revision = Revision.find(params[:id])
    @revision.destroy

    respond_to do |format|
      format.html { redirect_to(revisions_url) }
      format.xml  { head :ok }
    end
  end
end
