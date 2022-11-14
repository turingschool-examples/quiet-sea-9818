class PlotsController < ApplicationController
  def index
    @plots = Plot.all
    @plants = Plant.all
  end
end
