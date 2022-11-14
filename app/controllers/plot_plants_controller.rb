class PlotPlantsController < ApplicationController
  def destroy
    plot = Plot.find(params[:plot_id])
    plant = Plant.find(params[:id])
    PlotPlant.find_by(plot: plot.id, plant: plant.id).destroy

    redirect_to plots_path
  end
end