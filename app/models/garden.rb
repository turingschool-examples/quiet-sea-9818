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
end
