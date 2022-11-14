class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots
  has_many :plot_plants, through: :plants


  def all_plants
    plants.distinct.pluck(:name).join(", ")
  end

  def fast_harvest_plants
    plants.distinct.where("days_to_harvest < 100").pluck(:name).join(", ")
  end

  def sort_plants_by_count
    plants.select('plants.*, count(plants.id) as plant_count')
      .group(:id)
      .where("days_to_harvest < 100")
      .order('plant_count desc')
  end
end
