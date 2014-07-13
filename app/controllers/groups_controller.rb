class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find_by_id params[:id]
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to @group
    else 
      redirect_to "/"
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
    def group_params
      params.require(:group).permit(:name)
    end

end
