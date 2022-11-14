class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def plants_under_100_days
    plants.select('plants.*, count(plants.*) as num_plants').group(:id).where('days_to_harvest < 100').order(num_plants: :desc)
  end
end
