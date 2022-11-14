class Plant < ApplicationRecord
  has_many :plant_plots, dependent: :destroy
  has_many :plots, through: :plant_plots

end