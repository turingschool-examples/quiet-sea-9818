class PlotPlantsController < ApplicationController
  def destroy
    @plot_plant = PlotPlant.find_by(plant_id: params[:id], plot_id: params[:plot_id])
    @plot_plant.destroy

    redirect_to plots_path
  end
end