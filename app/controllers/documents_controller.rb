class DocumentsController < ApplicationController
  # GET /documents
  # GET /documents.xml
  def index
    @documents = Document.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @documents }
    end
  end

  def search
    if request.xhr?
      #Help to remove any empty queries fired off
      if params[:query].blank?
        @documents = Array.new
        @categories = Array.new
      else
        @documents = Document.find_with_ferret(params[:query]+"*", {:limit => 5})
        @categories = Category.find_with_ferret(params[:query]+"*", {:limit => 5})
      end
      render :partial => 'search_results'
    else
      @documents = Document.find_with_ferret(params[:query] + "*")
      @categories =  Category.find_with_ferret(params[:query]+"*")
      respond_to do |format|
        format.html # search.html.erb
        format.rss  # search.rss.erb
      end
    end
  end
  
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
    @document = Document.new
    @document.revisions.build

    #If there is a category, set that as the default
    if(!params[:category_id].blank?)
      @document.category_id = params[:category_id]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.xml
  def create
    @document = Document.new(params[:document])

    respond_to do |format|
      if @document.save
        flash[:notice] = 'Document was successfully created.'
        format.html { redirect_to(@document) }
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
        flash[:notice] = 'Document was successfully updated.'
        format.html { redirect_to(@document) }
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
      format.html { redirect_to(documents_url) }
      format.xml  { head :ok }
    end
  end

  #GET /documents/opensearch.xml
  def opensearch
    respond_to do |format|
      format.html { redirect_to(search_documents_url) }
      format.xml #opensearch.xml.erb
    end
  end
end
