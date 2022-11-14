class Garden < ApplicationRecord
  has_many :plots

  def plants_names
    self.plots.joins(:plants).where('plants.days_to_harvest < 100').distinct.pluck('plants.name')
  end
end
