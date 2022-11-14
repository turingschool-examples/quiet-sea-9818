class PlotPlant < ApplicationRecord
  belongs_to :plant
  belongs_to :plot

  def self.find_by_plant_and_plot_ids(input_plot_id, input_plant_id)
    where(plot_id: input_plot_id, plant_id: input_plant_id)
  end
end