class PlotPlant < ApplicationRecord
  belongs_to :plot
  belongs_to :plant

  def self.find_plot_plant(plant, plot)
    find_by(plot_id: plot.id, plant_id: plant.id)
  end
end