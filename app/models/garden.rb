class Garden < ApplicationRecord
  has_many :plots

  def short_harvest
    plots.joins(:plants).where("days_to_harvest < 100").pluck(:name).distinct
  end
end 


   
