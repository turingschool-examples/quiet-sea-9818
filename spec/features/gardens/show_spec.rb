require 'rails_helper'

RSpec.describe 'Garden Show' do
  before :each do
    @garden1 = Garden.create!(name: 'Backyard Garden', organic: true)

    @plot1 = Plot.create!(number: 1, size: 'small', direction: 'north', garden_id: @garden1.id)
    @plot2 = Plot.create!(number: 2, size: 'medium', direction: 'east', garden_id: @garden1.id)
    @plot3 = Plot.create!(number: 3, size: 'large', direction: 'south', garden_id: @garden1.id)

    @plant1 = Plant.create!(name: 'potato', description: 'grows in the ground', days_to_harvest: 30)
    @plant2 = Plant.create!(name: 'green bean', description: 'grows on a bush', days_to_harvest: 30)
    @plant3 = Plant.create!(name: 'orange', description: 'grows on a tree', days_to_harvest: 30)

    @plant4 = Plant.create!(name: 'squash', description: 'grows in the ground', days_to_harvest: 101)
    @plant5 = Plant.create!(name: 'tomato', description: 'grows on a bush', days_to_harvest: 101)
    @plant6 = Plant.create!(name: 'lemon', description: 'grows on a tree', days_to_harvest: 101)

    @pp1 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant1.id)
    PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant2.id)
    PlotPlant.create!(plot_id: @plot3.id, plant_id: @plant3.id)
    
    PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant4.id)
    PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant5.id)
    PlotPlant.create!(plot_id: @plot3.id, plant_id: @plant6.id)
  end
  describe 'Show' do
    it "Then I see a list of plants that are included in that garden's plots
    And I see that this list is unique (no duplicate plants)
    And I see that this list only includes plants that take less than 100 days to harvest" do

    visit "/gardens/#{@garden1.id}"
    save_and_open_page
    expect(page).to have_content(@plant1.name)
    expect(page).to have_content(@plant2.name)
    expect(page).to have_content(@plant3.name)

    expect(page).to_not have_content(@plant4.name)
    expect(page).to_not have_content(@plant5.name)
    expect(page).to_not have_content(@plant6.name)

    end
  end
end
