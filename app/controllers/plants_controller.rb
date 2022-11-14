class PlantsController < ApplicationController

  def index
    @plot = Plot.find(params[:plot_id])
    @plants = @plot.plants
  end
end
