class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def plants_quick_harvest
    # require "pry"; binding.pry
    plants.where('days_to_harvest < 100').distinct
  end
end
