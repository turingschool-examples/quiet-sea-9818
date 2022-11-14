require 'rails_helper'

RSpec.describe Plant do
  describe 'Relationships' do
    it { should have_many(:plot_plants) }
    it { should have_many(:plots).through(:plot_plants) }
  end
  before :each do
    @garden1 = Garden.create!(name: 'Backyard Garden', organic: true)

    @plot1 = Plot.create!(number: 1, size: 'small', direction: 'north', garden_id: @garden1.id)
    @plot2 = Plot.create!(number: 2, size: 'medium', direction: 'east', garden_id: @garden1.id)
    @plot3 = Plot.create!(number: 3, size: 'large', direction: 'south', garden_id: @garden1.id)

    @plant1 = Plant.create!(name: 'potato', description: 'grows in the ground', days_to_harvest: 30)
    @plant2 = Plant.create!(name: 'green bean', description: 'grows on a bush', days_to_harvest: 31)
    @plant3 = Plant.create!(name: 'orange', description: 'grows on a tree', days_to_harvest: 32)

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
  describe 'harvestable' do
    it 'joins plants and plots and filters out plants with over 100 days to harvest and orders them descending' do
      expect(Plant.harvestable).to eq([@plant3, @plant2, @plant1])
    end
  end
end
