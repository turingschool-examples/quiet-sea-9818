class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    # binding.pry
  end
end