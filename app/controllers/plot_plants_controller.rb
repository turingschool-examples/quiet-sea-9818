class PlotPlantsController < ApplicationController
  def destroy
    # require "pry"; binding.pry
    plot_plant = PlotPlant.find_plot_plant(params[:plot_id], params[:id])[0]
    plot_plant.destroy
    redirect_to plots_path
  end
end
