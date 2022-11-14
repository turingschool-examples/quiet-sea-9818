class Plant < ApplicationRecord
  has_many :plot_plants
  has_many :plots, through: :plot_plants
  has_many :gardens, through: :plots

  validates_presence_of :name, :description, :days_to_harvest
end