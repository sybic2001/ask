class MembershipsController < ApplicationController

  def index

  end

  def create
    @community = Community.find(params[:community_id])
    Membership.create(user: current_user, community: @community)
  end

  def update
    @membership = Membership.find(params[:id])
    @membership.update(membership_params)
  end


  private

  def membership_params
    params.require(:membership).permit(:status, :user, :community, :community_time_credit, :community_manager)
  end

end
