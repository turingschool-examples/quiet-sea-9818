class PlantsController < ApplicationController
  def destroy
    plant_plot = PlantPlot.where(plot: params[:plot_id], plant: params[:id]).first
    plant_plot.destroy
    redirect_to plots_path
  end
end