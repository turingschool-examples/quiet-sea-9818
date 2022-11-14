class PlotPlantsController < ApplicationController 
  def destroy
    @plot = Plot.find(params[:id])
    # require 'pry';binding.pry
    
    @delete_plant = @plot.plants.find(params[:id])
    # @delete_plant = Plant.find(params[:id])
    @delete_plant.destroy

    redirect_to plots_path
  end
end