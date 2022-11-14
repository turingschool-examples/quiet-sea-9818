class PlotPlantsController < ApplicationController
    def destroy 
        # binding.pry
        PlotPlant.destroy(params[:id])
        redirect_to "/plots"
    end
end