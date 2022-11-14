class Plot < ApplicationRecord
  belongs_to :garden
  has_many :plot_plants
  has_many :plants, through: :plot_plants

  def less_than_100
    self.plants.where("days_to_harvest < ?", 100)
  end
end
