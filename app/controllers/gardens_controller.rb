class GardensController < ApplicationController
  def show
    # require 'pry'; binding.pry
    @garden = Garden.find(params[:id])
    # require 'pry'; binding.pry
    # @garden.plots.each do |plot|
    #   require 'pry'; binding.pry
    # end
  end

end