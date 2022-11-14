class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plots
  has_many :plants, through: :plot_plants
  
  def unique_plants_under_100
    plants.select('plants.*', 'count(plants.*) as plant_count')
    .where('plants.days_to_harvest < 100')
    .group('plants.id')
    .order('plant_count desc')
    .distinct
  end
end
