class PlotPlant < ApplicationRecord
  belongs_to :plot
  belongs_to :plant
  
  def self.find_by_foreign_keys(plot_id, plant_id)
    PlotPlant.select('plot_plants.*')
    .where(["plot_id = ? and plant_id = ?", plot_id, plant_id])
    .first
  end
end