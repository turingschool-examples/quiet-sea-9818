class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plants = @garden.ordered_plants
  end
end