class PlotPlantsController < ApplicationController
  def destroy
    PlotPlant.destroy(params[:id])
    redirect_to plots_path
  end
end