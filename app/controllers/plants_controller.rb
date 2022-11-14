class PlantsController < ApplicationController
  def destroy
    # binding.pry
    plot_plant = PlotPlant.find_by_plant_and_plot_ids(params[:plot_id], params[:id]).first
    PlotPlant.destroy(plot_plant.id)

    redirect_to "/plots"
  end
end