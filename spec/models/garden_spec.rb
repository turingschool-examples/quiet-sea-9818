require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  describe 'instance methods' do
    describe '#plants_quick_harvest' do
      before :each do
        @garden1 = Garden.create!(name: 'Twinleaf Garden', organic: true)
        @garden2 = Garden.create!(name: 'Jubilife Garden', organic: false)
        @plot1 = @garden1.plots.create!(number: 1, size: 'Large', direction: 'East')
        @plot2 = @garden1.plots.create!(number: 2, size: 'Medium', direction: 'North')
        @plot3 = @garden1.plots.create!(number: 3, size: 'Small', direction: 'South')
        @plot4 = @garden2.plots.create!(number: 28, size: 'Large', direction: 'West')
        @plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich soil.", days_to_harvest: 90)
        @plant2 = Plant.create!(name: "Red Chili Pepper", description: "Very red.", days_to_harvest: 80)
        @plant3 = Plant.create!(name: "Napa Cabbage", description: "Requires loosened soil.", days_to_harvest: 70)
        @plant4 = Plant.create!(name: "Nuclear", description: "Radioactive, produces energy.", days_to_harvest: 600)
        @plant5 = Plant.create!(name: "Cactus", description: "Spiky.", days_to_harvest: 100)
        @plant6 = Plant.create!(name: "Test", description: "IDK.", days_to_harvest: 99)

        PlotPlant.create!(plot: @plot1, plant: @plant1)
        PlotPlant.create!(plot: @plot2, plant: @plant1)
        PlotPlant.create!(plot: @plot2, plant: @plant2)
        PlotPlant.create!(plot: @plot3, plant: @plant3)
        PlotPlant.create!(plot: @plot4, plant: @plant4)
        PlotPlant.create!(plot: @plot3, plant: @plant5)
        PlotPlant.create!(plot: @plot4, plant: @plant6)
      end
      it 'returns a unique list of plants that take less than 100 days to harvest' do
        expect(@garden1.plants_quick_harvest).to eq([@plant1, @plant2, @plant3])
        expect(@garden2.plants_quick_harvest).to eq([@plant6])
      end
    end
  end
end
