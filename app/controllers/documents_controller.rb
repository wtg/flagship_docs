class DocumentsController < ApplicationController
  # GET /documents
  # GET /documents.xml
  def index
    if admin_logged_in?
      #Admins will get a listing of all documents
      @documents = Document.all
    else
      #Regular users just see all the documents they can read
      @documents = Document.all
      #Scrub out all the documents the user cannot read
      @documents.delete_if{|d| !d.can_read(current_user)}
    end
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
      #Filter out results that you won't be able to see
      @documents.delete_if{|d| !d.can_read(current_user)}
      @categories.delete_if{|c| !c.can_read(current_user)}
      render :partial => 'search_results'
    else
      @documents = Document.find_with_ferret(params[:query] + "*")
      @categories =  Category.find_with_ferret(params[:query]+"*")
      #Filter out results that you won't be able to see
      @documents.delete_if{|d| !d.can_read(current_user)}
      @categories.delete_if{|c| !c.can_read(current_user)}
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
    
    if !@document.can_read(current_user)
      flash[:error] = 'Access denied'
      redirect_to(@document.category)
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @document }
      end
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
    if !@document.can_write(current_user)
      flash[:error] = 'Access denied'
      redirect_to(@document)
    end
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
    if !@document.can_write(current_user)
      flash[:error] = 'Access denied'
      redirect_to(@document)
    else
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
  end

  # DELETE /documents/1
  # DELETE /documents/1.xml
  def destroy
    @document = Document.find(params[:id])
    if !@document.can_write(current_user)
      flash[:error] = 'Access denied'
      redirect_to(@document)
    else
      @document.destroy

      respond_to do |format|
        format.html { redirect_to(documents_url) }
        format.xml  { head :ok }
      end
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
