class CommunitiesController < ApplicationController
  def index
    @communities = Community.all
  end

  def show
    @community = Community.find(params[:id])
    redirect_to root_path(access: "unauthorized") if !current_user.is_member?(@community)
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)
    if @community.save
      Membership.create(user: current_user, community: @community, community_manager: true, status: "member")
      redirect_to communities_path
    else
      render 'new'
    end
  end

  def edit
    @community = Community.find(params[:id])
    redirect_to communities_path(@community) if !current_user.is_community_manager?(@community)
  end

  private

  def community_params
    params.require(:community).permit(:name, :url, :photo, :description)
  end
end
