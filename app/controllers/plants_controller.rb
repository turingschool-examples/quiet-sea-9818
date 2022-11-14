class PlantsController < ApplicationController
  def destroy
    plant = Plant.find(params[:id])
    plant.destroy
    redirect_to '/plots'
  end
end
