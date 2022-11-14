class GardensController < ApplicationController

  def show
    @garden = Garden.find(params[:id])
    @plots = @garden.plots
  end

end
