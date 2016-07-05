class ProfilesController < ApplicationController
  def show
    @user_competency = UserCompetency.new
    @user = User.find(params[:id])
    @private_profile = current_user.id == params[:id].to_i
    render :show_private
  end
end
