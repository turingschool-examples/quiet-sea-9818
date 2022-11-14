class PlotPlantsController < ApplicationController

  def destroy
    @plot = Plot.find(params[:plot_id])
    @plot_plant = @plot.plot_plants.find(params[:id])
    @plot_plant.destroy
    redirect_to "/plots"
  end
end
