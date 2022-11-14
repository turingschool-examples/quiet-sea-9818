class PlotsController < ApplicationController
  def index
    @plots = Plot.all
    # require "pry"; binding.pry
  end
end
