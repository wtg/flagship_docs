class RevisionsController < ApplicationController
  # GET /revisions/new
  # GET /revisions/new.xml
  def new
    @document = Document.find(params[:document_id])
    @revision = Revision.new(:document => @document)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @revision }
    end
  end

  # POST /revisions
  # POST /revisions.xml
  def create
    @document = Document.find(params[:document_id])
    @revision = Revision.new(params[:revision])
    @revision.document = @document

    respond_to do |format|
      if @revision.save
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
    @revision = Revision.find(params[:id])
    @revision.increment!(:download_count)
    send_data @revision.file_contents, :filename => @revision.file_name, :type => @revision.file_type, :disposition => 'inline'
  end
end
