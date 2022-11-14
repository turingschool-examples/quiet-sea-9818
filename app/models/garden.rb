class Garden < ApplicationRecord
  has_many :plots

  def uniq_plants_short_harvest
     plots.joins(:plant_plots)
          .select("plants.name")
          .group("plants.name").where("plants.days_to_harvest < 100")
          .distinct
  end
end
