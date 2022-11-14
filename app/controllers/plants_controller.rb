class PlantsController < ApplicationController
  def destroy 
    @plant = Plant.find(params[:id])
    @plot = @plant.plots.first 
    @plot.plants.delete(@plant)
    redirect_to plots_path
  end
end