class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def short_harvest_plants
    plants.select("plants.name, count(plants.*) as count")
          .group(:id)
          .where("plants.days_to_harvest < 100")
          .order(count: :desc)
          .pluck(:name)
  end
end
