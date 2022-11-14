class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plants = @garden.plants_quick_harvest
    # require "pry"; binding.pry
  end
end
