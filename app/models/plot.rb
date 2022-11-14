class Plot < ApplicationRecord
  belongs_to :garden
  has_many :plot_plants
  has_many :plants, through: :plot_plants

  # def plant_names
  #   plot
  #   .joins(:plants)
  #   .select('plants.*')
  #   .group(:name)
  # end
end
