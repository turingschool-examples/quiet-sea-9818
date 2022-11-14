class PlotPlantsController < ApplicationController
  def destroy
    plot_plant = PlotPlant.find_by_foreign_keys(params[:plot_id], params[:id])
    plot_plant.destroy
    redirect_to '/plots'
  end
end