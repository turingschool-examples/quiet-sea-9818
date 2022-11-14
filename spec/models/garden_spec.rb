require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe "methods" do
    before :each do
      @garden_1 = Garden.create!(name: "Turing Community Garden", organic: true)
      @plot_1 = @garden_1.plots.create!(number: 25, size: "Large", direction: "East")
      @plot_2 = @garden_1.plots.create!(number: 26, size: "Medium", direction: "North")
      @plot_3 = @garden_1.plots.create!(number: 27, size: "Small", direction: "West")
      @plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefer Rich", days_to_harvest: 100)
      @plant_2 = Plant.create!(name: "Red Beauty", description: "Prefer Poor", days_to_harvest: 30)
      @plant_3 = Plant.create!(name: "Blue Beauty", description: "Prefer Average", days_to_harvest: 45)
      @plot_plant_1 = PlotPlant.create(plot: @plot_1, plant: @plant_1)
      @plot_plant_2 = PlotPlant.create(plot: @plot_2, plant: @plant_2)
      @plot_plant_3 = PlotPlant.create(plot: @plot_3, plant: @plant_3)
      @plot_plant_4 = PlotPlant.create(plot: @plot_3, plant: @plant_3)
      @plot_plant_5 = PlotPlant.create(plot: @plot_3, plant: @plant_2)
    end

    it "can show unique plants" do
      expect(@garden_1.show_unique).to eq([@plant_2, @plant_3])
      expect(@garden_1.show_unique).to_not eq([@plant_1, @plant_2, @plant_3, @plant_3, @plant_2])
    end
  end
end
