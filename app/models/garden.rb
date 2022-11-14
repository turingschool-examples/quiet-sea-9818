class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots 

  def plant_list
    plants.where('days_to_harvest < ?', '100').distinct.pluck(:name)
  end

  def plant_order
    plants.where('days_to_harvest < ?', '100')
    .select('plants.name as name, plants.count as count')
    .group(:name)
    .order(Arel.sql("count('plants.name') desc"))
  end
end
