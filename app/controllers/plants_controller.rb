class PlantsController < ApplicationController
  def destroy
    plant = Plant.find(params[:plant_id])
    plot = Plot.where(id: params[:plot_id]).first
    plot_plants = PlotPlant.where(plant_id: params[:plant_id], plot_id: params[:plot_id]).first
    plot_plants.destroy
    redirect_to '/plots'
  end
end