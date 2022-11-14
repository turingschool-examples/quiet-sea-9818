class Garden < ApplicationRecord
  has_many :plots

  def garden_plants
    plots.joins(:plants)
    .where('days_to_harvest < ?', 100)
    .distinct
    .pluck(:name)
  end
end
