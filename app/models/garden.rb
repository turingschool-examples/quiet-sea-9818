class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def short_harvest_plants
    plants
      .where('days_to_harvest < ?', 100)
      .distinct
  end

  def all_plants
    plants
      .select('plants.*, count(plants) AS plant_count')
      .group(:id)
      .order(plant_count: :desc)
  end
end
