require 'rails_helper'

RSpec.describe 'garden show page' do
  before :each do
    @garden1 = Garden.create!(name: "fun garden", organic: true)
    
    @plot1 = Plot.create!(number: 1, size: "10ft", direction: "north", garden_id: @garden1.id)
    @plot2 = Plot.create!(number: 2, size: "20ft", direction: "south", garden_id: @garden1.id)
    @plot3 = Plot.create!(number: 3, size: "30ft", direction: "east", garden_id: @garden1.id)
    
    @plant1 = Plant.create!(name: "daisy", description: "flower", days_to_harvest: 3)
    @plant2 = Plant.create!(name: "green beans", description: "edible", days_to_harvest: 33)
    @plant3 = Plant.create!(name: "potatoe", description: "edible", days_to_harvest: 111)

    @plot_plants1 = PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot1.id)
    @plot_plants2 = PlotPlant.create!(plant_id: @plant2.id, plot_id: @plot2.id)
    @plot_plants3 = PlotPlant.create!(plant_id: @plant3.id, plot_id: @plot2.id)
    @plot_plants4 = PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot2.id)
   
  end

  describe 'as a visitor' do
    it 'i see a list of plants that are included in this garden' do
      visit garden_path(@garden1)

      expect(page).to have_content(@garden1.name)
      expect(page).to have_content(@plant1.name, count: 1)
      expect(page).to have_content(@plant2.name)
      expect(page).to_not have_content(@plant3.name)
    end
  end
end



# User Story 3, Garden's Plants
# As a visitor
# When I visit a garden's show page
# Then I see a list of plants that are included in that garden's plots
# And I see that this list is unique (no duplicate plants)
# And I see that this list only includes plants that take less than 100 days to harvest