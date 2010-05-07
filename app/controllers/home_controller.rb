class HomeController < ApplicationController
  # GET /index
  # GET /index.xml
  def index
    @featured_categories = Category.find( :all, :conditions => { :is_featured => true } )
    @featured_categories.delete_if {|x| !x.allowed_to_read} #Hide Private Featured Categories

    @categories = Category.roots
    @categories.delete_if {|x| !x.allowed_to_read} #Hide Private Root Categories

    respond_to do |format|
      format.html # index.html.erb
      format.rss
      format.xml  { render :xml => @categories }
    end
  end
end
