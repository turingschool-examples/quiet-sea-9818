class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plants_under_100_days = @garden.plants_under_100_days
  end
end