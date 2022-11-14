class Garden < ApplicationRecord
  has_many :plots
  has_many :plot_plants, through: :plots 
  has_many :plants, through: :plot_plants
  

  def garden_plants
    self.plants
#ran out of time to finalize method to return plant names here. 
  end
end
