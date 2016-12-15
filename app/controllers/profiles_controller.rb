class ProfilesController < ApplicationController
  def show
    @user_competency = UserCompetency.new
    @user = User.find(params[:id])
    @private_profile = current_user.id == params[:id].to_i
    render :show_private
  end

  def edit
    @profile = current_user.profile
  end

  def update
    current_user.profile.update(profile_params)
    redirect_to profile_path(current_user)
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :city, :address, :photo, :description, :phone_number, :zip_code, :country)
  end

end
