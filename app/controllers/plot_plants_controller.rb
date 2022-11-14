class PlotPlantsController < ApplicationController
  def destroy
    plot_plant = PlotPlant.find_plot_plant(params[:plot_id], params[:plant_id])[0]
    plot_plant.destroy
    redirect_to plots_path
  end
end
