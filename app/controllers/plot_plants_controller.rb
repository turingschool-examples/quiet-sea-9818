class PlotPlantsController < ApplicationController

  def destroy 

    # @plotplant = PlotPlant.find(params[:id])
    # PlotPlant.destroy(@plotplant.id)
    plant = Plant.find(params[:id])
    plant.plots.destroy(params[:id])
  

    redirect_to plots_path
  end
end