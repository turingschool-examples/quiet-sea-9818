class PlotsController < ApplicationController

  def index
    @plots = Plot.all
    @plot = Plot.find(params[:id])
    @plants = @plot.plants
  end

end
