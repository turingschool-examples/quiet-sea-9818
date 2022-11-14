class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def unique_under_100_harvest
    plants.where('days_to_harvest < 100').distinct
  end

end
