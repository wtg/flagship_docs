class RevisionsController < ApplicationController
  # GET /revisions
  # GET /revisions.xml
  def index
    @revisions = Revision.find(:all, :conditions => {:document_id => params[:document_id]})

    if !@revisions.first.document.allowed_to_read
      redirect_back
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @revisions }
      end
    end
  end

  # GET /revisions/1
  # GET /revisions/1.xml
  def show
    if params[:id] == 'current'
      @revision = Document.find(params[:document_id]).current_revision
    else
      @revision = Revision.find(params[:id])
    end

    if !@revision.document.allowed_to_read
      redirect_back
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @revision }
      end
    end
  end

  # GET /revisions/new
  # GET /revisions/new.xml
  def new
    @revision = Revision.new
    @revision.document_id = params[:document_id]

    if !@revision.document.allowed_to_save
      redirect_back
    else
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @revision }
      end
    end
  end

  # GET /revisions/1/edit
  def edit
    @revision = Revision.find(params[:id])
    if !@revision.document.allowed_to_save
      redirect_back
    end
  end

  # POST /revisions
  # POST /revisions.xml
  def create
    @revision = Revision.new(params[:revision])
    @revision.document_id = params[:document_id]
		@revision.user_id = current_user.id
    respond_to do |format|
      if @revision.save
        flash[:notice] = 'Revision was successfully created.'
        format.html { redirect_to(@revision.document) }
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
    if !revision.document.allowed_to_save
      redirect_back
    else
      @revision.destroy
    end

    respond_to do |format|
      format.html { redirect_to(revisions_url) }
      format.xml  { head :ok }
    end
  end

  def download
   if params[:id] == 'current'
      revision = Document.find(params[:document_id]).current_revision
   else
      revision = Revision.find(params[:id])
   end

   if revision.document.allowed_to_read
     revision.document.increment!(:downloaded)
   
     send_data revision.upload.file_contents(:original),
               :filename => revision.upload_file_name,
               :type => revision.upload_content_type
   else
     redirect_back
   end
 end
end
