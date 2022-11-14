class PlotPlant < ApplicationRecord
  belongs_to :plot
  belongs_to :plant

  def self.find_plot_plant(plot_id, plant_id)
    PlotPlant.where(plant_id: plant_id, plot_id: plot_id)
  end
end
