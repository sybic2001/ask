class ExperiencesController < ApplicationController
  def new
    @experience = Experience.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def experience_params
    params.require(:experience).permit()
  end
end
