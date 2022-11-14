class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plots_and_plants = Plant.harvestable
  end
end
