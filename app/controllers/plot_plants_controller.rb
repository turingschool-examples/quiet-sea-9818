class PlotPlantsController < ApplicationController
  def destroy
    plot = Plot.find(params[:plot_id])
    plant = Plant.find(params[:id])
    PlotPlant.find_plot_plant(plant, plot).destroy

    redirect_to plots_path
  end
end