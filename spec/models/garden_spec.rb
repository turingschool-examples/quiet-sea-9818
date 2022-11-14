require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end
#   before :each do
#     @garden1 = Garden.create!(name: "fun garden", organic: true)
    
#     @plot1 = Plot.create!(number: 1, size: "10ft", direction: "north", garden_id: @garden1.id)
#     @plot2 = Plot.create!(number: 2, size: "20ft", direction: "south", garden_id: @garden1.id)
#     @plot3 = Plot.create!(number: 3, size: "30ft", direction: "east", garden_id: @garden1.id)
    
#     @plant1 = Plant.create!(name: "daisy", description: "flower", days_to_harvest: 3)
#     @plant2 = Plant.create!(name: "green beans", description: "edible", days_to_harvest: 33)
#     @plant3 = Plant.create!(name: "potatoe", description: "edible", days_to_harvest: 111)

#     @plot_plants1 = PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot1.id)
#     @plot_plants2 = PlotPlant.create!(plant_id: @plant2.id, plot_id: @plot2.id)
#     @plot_plants3 = PlotPlant.create!(plant_id: @plant3.id, plot_id: @plot2.id)
#     @plot_plants4 = PlotPlant.create!(plant_id: @plant3.id, plot_id: @plot2.id)
   
#   end
# # And I see that this list only includes plants that take less than 100 days to harvest
#   describe '#less_than_100' do
#     it 'returns plants that take less than 100 days to harvest' do
#       expect(@garden1.less_than_100).to eq([@plant1, @plant2])
#     end
#   end
end
