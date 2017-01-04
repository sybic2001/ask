class BadgesController < ApplicationController
  def index
    @competency = Competency.find(params[:competency_id])
  end
end
