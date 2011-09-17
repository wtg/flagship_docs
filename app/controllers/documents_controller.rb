class DocumentsController < ApplicationController
  # GET /documents/1
  # GET /documents/1.xml
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.xml
  def new
    @category = nil
    @category = Category.find(params[:category_id]) if params[:category_id]

    @document = Document.new(:category => @category)
    @document.revisions.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
    @document.revisions = [Revision.new(:document => @document)]
  end

  # POST /documents
  # POST /documents.xml
  def create
    @document = Document.new(params[:document])

    respond_to do |format|
      if @document.save
        @document.revisions.current.first.delay.update_search_text unless @document.revisions.empty?
        format.html { redirect_to(@document, :notice => 'Document was successfully created.') }
        format.xml  { render :xml => @document, :status => :created, :location => @document }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.xml
  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to(@document, :notice => 'Document was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.xml
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to(category_url(@document.category), :notice => 'Document was successfully removed.') }
      format.xml  { head :ok }
    end
  end
  
  # GET /documents/search
  def search 
    @document_search = Document.search do
      fulltext params[:query], :highlight => true
    end

    @categories = Category.search do
      fulltext params[:query]
    end.results

    respond_to do |format|
      format.html # show.html.erb
    end
  end
end
