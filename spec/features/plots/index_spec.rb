require 'rails_helper'

RSpec.describe 'Plot Index' do
  before :each do
    @garden1 = Garden.create!(name: 'Backyard Garden', organic: true)

    @plot1 = Plot.create!(number: 1, size: 'small', direction: 'north', garden_id: @garden1.id)
    @plot2 = Plot.create!(number: 2, size: 'medium', direction: 'east', garden_id: @garden1.id)
    @plot3 = Plot.create!(number: 3, size: 'large', direction: 'south', garden_id: @garden1.id)

    @plant1 = Plant.create!(name: 'potato', description: 'grows in the ground', days_to_harvest: 30)
    @plant2 = Plant.create!(name: 'green bean', description: 'grows on a bush', days_to_harvest: 30)
    @plant3 = Plant.create!(name: 'orange', description: 'grows on a tree', days_to_harvest: 30)

    PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant1.id)
    PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant2.id)
    PlotPlant.create!(plot_id: @plot3.id, plant_id: @plant3.id)
  end
  describe 'index' do
    it "I see a list of all plot numbers and under each plot number I see the names of all that plot's plants" do
      visit "/plots"

      expect(page).to have_content("Plot Number: 1")
      expect(page).to have_content("Plot Number: 2")
      expect(page).to have_content("Plot Number: 3")
      expect(page).to have_content('Plant Name: potato')
      expect(page).to have_content('Plant Name: green bean')
      expect(page).to have_content('Plot Number: 3')

    end
  end
end
