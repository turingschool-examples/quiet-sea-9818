class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plants = @garden.garden_plants
  end
end