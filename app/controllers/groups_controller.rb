class GroupsController < ApplicationController

  before_filter :admin?, except: [:show]

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
    @group = Group.find_by_id(params[:id])
  end

  def update
    @group = Group.find_by_id(params[:id])
    @group.update_attributes(group_params)
    redirect_to @group
  end

  def add_member
    leader = Membership.new(leader_params)
    leader.group_id = params[:id]
    leader.save

    redirect_to edit_group_path(params[:id])
  end

  def destroy
    group = Group.find_by_id(params[:id])
    group.destroy
    redirect_to groups_path
  end

  private
    def group_params
      params.require(:group).permit(:name)
    end

    def leader_params
      params.require(:membership).permit(:user_id, :level)
    end

end
