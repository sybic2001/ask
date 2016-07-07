class MembershipsController < ApplicationController

  def index
    @community = Community.find(params[:community_id])
    redirect_to root_path if current_user.memberships.where(community: @community).empty? || !current_user.memberships.find_by(community: @community).community_manager

  end

  def create
    @community = Community.find(params[:community_id])
    Membership.create(user: current_user, community: @community)
  end
end
