class PlotPlantsController < ApplicationController
  def destroy
    # require 'pry'; binding.pry
    PlotPlant.find(params[:id]).destroy
    redirect_to plots_path
  end
end