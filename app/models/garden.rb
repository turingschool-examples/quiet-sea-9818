class Garden < ApplicationRecord
  has_many :plots

  def harvest_less_than_100
    plots.joins(:plants).where("days_to_harvest < 100").distinct.pluck(:name)
  end
end
