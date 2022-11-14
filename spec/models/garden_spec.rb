require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots)}
    it { should have_many(:plot_plants).through(:plants) }
  end

  before :each do
    @garden = Garden.create!(name: "Turing Community Garden", organic: true)
    @plot1 = Plot.create!(number: 25, size: "Large", direction: "East", garden: @garden)
    @plot2 = Plot.create!(number: 26, size: "Medium", direction: "West", garden: @garden)
    @plant1 = Plant.create!(name: "Plant1", description: "desc1", days_to_harvest: 60)
    @plant2 = Plant.create!(name: "Plant2", description: "desc2", days_to_harvest: 65)
    @plant3 = Plant.create!(name: "Plant3", description: "desc3", days_to_harvest: 75)
    @plant4 = Plant.create!(name: "Plant4", description: "desc4", days_to_harvest: 120)
    @pp1 = PlotPlant.create!(plot: @plot1, plant: @plant1)
    @pp2 = PlotPlant.create!(plot: @plot1, plant: @plant3)
    @pp3 = PlotPlant.create!(plot: @plot2, plant: @plant2)
    @pp4 = PlotPlant.create!(plot: @plot2, plant: @plant4)
    @pp5 = PlotPlant.create!(plot: @plot1, plant: @plant4)
  end

  describe "Instance Methods" do
    describe "#all_plants" do
      it "returns a unique list plant names within the garden across all garden plots" do
        expect(@garden.all_plants).to eq("Plant1, Plant2, Plant3, Plant4")
      end
    end

    describe "#fast_harvest_plants" do
      it "returns a list of plants that take less than 100 days to harvest" do
        expect(@garden.fast_harvest_plants).to eq("Plant1, Plant2, Plant3")
      end
    end
  end
end
