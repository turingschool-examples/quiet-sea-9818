class PlantPlotsController < ApplicationController  
  def destroy 
    plot = Plot.find(params[:plot_id])
    plant = Plant.find(params[:id])
    association = PlantPlot.find_by(plant: plant, plot: plot)
    
    association.destroy 

    redirect_to plots_path
  end
end