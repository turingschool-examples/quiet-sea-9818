class Garden < ApplicationRecord
  has_many :plots

  def garden_plants
    self.plots.select('plants.*, count(plants.id) as plant_count').where('plants.days_to_harvest < 100').joins(:plants).group('plants.id').order('plant_count desc')
  end
end
