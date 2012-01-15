class RevisionsController < ApplicationController
  before_filter :get_document

  # GET /revisions/new
  # GET /revisions/new.xml
  def new
    @revision = Revision.new(:document => @document)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @revision }
    end
  end

  # POST /revisions
  # POST /revisions.xml
  def create
    @revision = Revision.new(params[:revision])
    @revision.document = @document
    @revision.user = current_user

    respond_to do |format|
      if @revision.save
        #@revision.delay.update_search_text
        format.html { redirect_to(@revision.document, :notice => 'Revision was successfully created.') }
        format.xml  { render :xml => @revision, :status => :created, :location => @revision }
      else
        format.html { render :action => "new" }
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
      format.html { redirect_to(document_url(@revision.document)) }
      format.xml  { head :ok }
    end
  end

  # GET /revisions/1/download
  def download
    if params[:id] == 'current'
      @revision = @document.revisions.current.first
    else
      @revision = Revision.find(params[:id])
    end
    @revision.increment!(:download_count)
    send_data @revision.file_contents, :filename => @revision.file_name, :type => @revision.file_type, :disposition => 'inline'
  end


  private
  
  # Get the current document.  Since revisions
  # are always scoped off the document ID we can
  # always grab a @document.
  #
  # TODO: Fail if a document can't be found.
  def get_document
    @document = Document.find(params[:document_id])
  end

end
