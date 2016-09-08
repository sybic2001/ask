class UserCompetenciesController < ApplicationController

  def index
    @peer_competencies = current_user.peer_competencies.where.not(user: current_user).order(:competency_id, level: :desc)
    @competencies = Competency.all
  end

  def search
    @peer_competencies = current_user.peer_competencies.where.not(user: current_user).where(competency_id: params[:filters][:competencies]).order(:competency_id, level: :desc)
    # @cities = params[:city]
    # @competencies = params[:competences]
    # @communities = params[:communities]
    # @levelmin = params[:level]
    p @peer_competencies
  end

  def create
    @user_competency = UserCompetency.new(user_competency_params)
    @user_competency.user = current_user
    if @user_competency.save
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

  def destroy
    @user_competency = UserCompetency.find(params[:id])
    @user_competency.destroy
  end

  def edit
    @user_competency = UserCompetency.find(params[:id])
  end

  def update
    @user_competency = UserCompetency.find(params[:id])
    if @user_competency.update(user_competency_params)
      respond_to do |format|
        format.html { redirect_to profile_path(@user) }
        format.js  # <-- will render `app/views/reviews/update.js.erb`
      end
    end
  end

  private

  def user_competency_params
    params.require(:user_competency).permit(:level, :competency_id, :description)
  end
end
