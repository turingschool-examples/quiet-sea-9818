class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plants = @garden.plants.distinct
  end
end