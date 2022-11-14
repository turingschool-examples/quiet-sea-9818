class PlotPlantsController < ApplicationController
  def destroy
    plotplant = PlotPlant.find(params[:id])
    plotplant.destroy
    redirect_to(plots_path)
  end
end
