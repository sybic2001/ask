class ProfilesController < ApplicationController
  def show
    if current_user.id == params[:id].to_i
      render :show_private
    else
      render :show_public
    end
  end
end
