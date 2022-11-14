class Plant < ApplicationRecord
    has_many :plot_plants
    has_many :plots, through: :plot_plants
    
    def self.harvestable
        where("plants.days_to_harvest < ?","100")
        .joins(:plots)
    end
end