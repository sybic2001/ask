class MembershipsController < ApplicationController

  def index

  end

  def new
    @membership = Membership.new
    @community = Community.find(params[:community_id])
  end

  def create
    @community = Community.find(params[:community_id])
    @membership = Membership.new(membership_params)
    @membership.user = current_user
    @membership.community = @community
    @membership.save
  end

  def update
    @membership = Membership.find(params[:id])
    @membership.update(membership_params)
  end


  private

  def membership_params
    params.require(:membership).permit(:promotion, :status, :community_manager)
  end

end
