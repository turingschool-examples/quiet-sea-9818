require 'rails_helper'

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  let!(:garden1) { Garden.create!(name: 'Bat World', organic: true) }
  let!(:garden2) { Garden.create!(name: 'Krytpon', organic: false) }

  let!(:plant1) { Plant.create!(name: 'Batplant', description: 'Tastes like chicken', days_to_harvest: 50) }
  let!(:plant2) { Plant.create!(name: 'Kryptonian Tomato', description: 'Tastes like radiation', days_to_harvest: 80) }
  let!(:plant3) { Plant.create!(name: 'Banana', description: 'Probably a vegetable', days_to_harvest: 15) }
  let!(:plant4) { Plant.create!(name: 'Yarrow Flower', description: 'For Migo', days_to_harvest: 180) }
  let!(:plant5) { Plant.create!(name: 'Blueberries', description: 'Also a vegetable', days_to_harvest: 99) }

  let!(:plot1) { garden1.plots.create!(number: 4, size: 'Medium', direction: 'West') }
  let!(:plot2) { garden1.plots.create!(number: 15, size: 'Small', direction: 'West') }
  let!(:plot3) { garden1.plots.create!(number: 24, size: 'Medium', direction: 'South') }
  let!(:plot4) { garden1.plots.create!(number: 1, size: 'Large', direction: 'East') }
  let!(:plot5) { garden1.plots.create!(number: 45, size: 'Small', direction: 'North') }
  let!(:plot6) { garden2.plots.create!(number: 71, size: 'Medium', direction: 'West') }
  let!(:plot7) { garden2.plots.create!(number: 100, size: 'Large', direction: 'North') }

  let!(:plant_plot1) { PlantPlot.create!(plant_id: plant1.id, plot_id: plot1.id) }
  let!(:plant_plot2) { PlantPlot.create!(plant_id: plant1.id, plot_id: plot2.id) }
  let!(:plant_plot3) { PlantPlot.create!(plant_id: plant2.id, plot_id: plot1.id) }
  let!(:plant_plot4) { PlantPlot.create!(plant_id: plant3.id, plot_id: plot7.id) }
  let!(:plant_plot5) { PlantPlot.create!(plant_id: plant4.id, plot_id: plot5.id) }
  let!(:plant_plot6) { PlantPlot.create!(plant_id: plant5.id, plot_id: plot4.id) }

  describe 'instance methods' do
    it 'can return unique list of plants in all plots with harvest times under 100 days' do
      expect(garden1.short_harvest_plants).to eq([plant1, plant2, plant5])
      expect(garden2.short_harvest_plants).to eq([plant3])
    end

    it 'can return all plants sorted from most to least' do
      expect(garden1.all_plants).to eq([plant1, plant2, plant4, plant5])
      expect(garden2.all_plants).to eq([plant3])
    end
  end
end
