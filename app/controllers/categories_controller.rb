class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.roots
    @categories.delete_if {|x| !x.can_read(current_user)}#Delete Private Root Categories
		respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
		@category = Category.find(params[:id])
		if @category.can_read(current_user)#Show Only if the user is allowed to see it
    	respond_to do |format|
      	format.html # show.html.erb
      	format.rss #show.rss.erb
      	format.xml  { render :xml => @category }
			end
		else
			flash[:notice] = 'You are not authorized to view this Category.'
			redirect_back
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
			@category = Category.new
    	#If there is a category, set that as the default parent
    	if(!params[:parent_id].blank?)
      		@category.parent_id = params[:parent_id]	
			end
    	respond_to do |format|
      	format.html # new.html.erb
      	format.xml  { render :xml => @category }
    	end
	end
  
	# GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
		if !@category.is_owner(current_user)
			flash[:notice] = 'Only The owner of this category or Super Admins are allowed to edit this Category'
			redirect_back
		end
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])
		#checks to see if this category is to be a sub-category
		if !@category.parent_id.blank?
			#since it is a sub-category, let's find the parent category and see if the user has access (ie. user is superadmin or admins the group that owns the category)
			@parentcat = Category.find(@category.parent_id)
			if !@parentcat.is_owner(current_user)
				#the user is not an owner of the parent category, he can't create new categories in here.
				flash[:notice] = 'You do not own the category in which you are creating the subcategory. Contact the Owner of the Category for Assistance.'
				redirect_back
			end
		elsif !current_user.is_admin
			#The user wants to create a category in the 'root' folder. Only Super Admins can do that. This person is not a super admin. It Fails
			flash[:notice] = 'Only Super Admins are allowed to create categories in the root folder. Contact one for assistance.'
			redirect_back
		end
    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to(@category) }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])
		#only users who own this category can change it. Super Admins can change it too.
		if @category.is_owner(current_user)
    	respond_to do |format|
      	if @category.update_attributes(params[:category])
        	flash[:notice] = 'Category was successfully updated.'
        	format.html { redirect_to(@category) }
        	format.xml  { head :ok }
      	else
        	format.html { render :action => "edit" }
        	format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      	end
    end
		else
			flash[:notice] = 'Only the Owner of this Category or Super Admins may alter this Category'
			#redirecting back the user. He cannot edit this category.
			redirect_back
		end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])
		if @category.is_owner(current_user)
    	@category.destroy
			flash[:notice] = 'Category was successfully deleted.'
    	respond_to do |format|
      	format.html { redirect_to(categories_url) }
      	format.xml  { head :ok }
    	end
  	end
	end
end
