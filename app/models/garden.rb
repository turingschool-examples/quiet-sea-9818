class Garden < ApplicationRecord
  has_many :plots
  has_many :plant_plots, through: :plots
  has_many :plants, through: :plant_plots

  def ordered_plants
    plants.joins(:plant_plots)
      .select('plants.*, count(plants.id) AS count')
      .group('plants.id')
      .order('count desc')
      .distinct
  end
end
