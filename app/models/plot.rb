class Plot < ApplicationRecord
  belongs_to :garden
  has_many :plant_plots
  has_many :plants, through: :plant_plots

  def plant_plot_id(plant)
    plant_plots.where(plant_id: plant.id).first.id
  end
end
