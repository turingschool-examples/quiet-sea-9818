class PlantPlotsController < ApplicationController  
  def destroy 
    garden = Garden.find(params[:garden_id])
    plot = Plot.find(params[:plot_id])
    plant = Plant.find(params[:id])
    association = PlantPlot.find_by(plant: plant, plot: plot)
    
    association.destroy 

    redirect_to garden_plots_path(garden)
  end
end