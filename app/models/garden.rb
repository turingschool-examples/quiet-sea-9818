class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plots
  has_many :plants, through: :plot_plants

  validates_presence_of :name

  def list_garden_plants
    plants
      .where('days_to_harvest < 100')
      .distinct
  end

  # def self.order_garden_plants
  #   select("plot_plants.*, count('plot_plants.plant_id') as plant_count")
  #   .order('plant_count')
  # end
end
