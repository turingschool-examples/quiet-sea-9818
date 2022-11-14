class GardensController < ApplicationController
  def show
    @garden = Garden.find_by(id: params[:garden_id])
  end


end