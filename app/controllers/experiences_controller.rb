class ExperiencesController < ApplicationController
  def new
    @experience = Experience.new
    @user_competency = UserCompetency.find(params[:user_competency_id])
    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  def create
    @experience = Experience.new(experience_params)
    @user_competency = UserCompetency.find(params[:user_competency_id])
    @experience.user_competency = @user_competency
    if @experience.save
      respond_to do |format|
        format.html { redirect_to profile_path(@user) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'profiles/show_private' }
        format.js  # <-- idem
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @experience = Experience.find(params[:id])
    @experience_id = @experience.id
    @experience.destroy
  end

  private

  def experience_params
    params.require(:experience).permit(:year, :company, :duration, :description)
  end
end
