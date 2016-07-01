class UserCompetenciesController < ApplicationController
  def create
    @user = current_user
    @user_competency = UserCompetency.new(user_competency_params)
    @user.user_competency = @user
    if @user_competency.save
      respond_to do |format|
        format.html { redirect_to profile_path(@user) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      # respond_to do |format|
      #   format.html { render 'restaurants/show' }
      #   format.js  # <-- idem
      # end
    end
  end

  private

  def user_competency_params
    params.require(:user_competency).permit(:competency, :level)
  end
end
