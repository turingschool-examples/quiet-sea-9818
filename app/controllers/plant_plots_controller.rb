class PlantPlotsController < ApplicationController
  def destroy
    PlantPlot.find_by(plot_id: params[:plot_id], plant_id: params[:id]).destroy
    redirect_to plots_path
  end
end
