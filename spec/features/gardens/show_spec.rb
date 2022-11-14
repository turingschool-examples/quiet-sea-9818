require "rails_helper"

RSpec.describe "the Garden Show page" do 
  before(:each) do 
    @garden = Garden.create!(name: "Cole Neighborhood Garden", organic: false)
    @plot_1 = @garden.plots.create!(number: 1, size: "Large", direction: "East")
    @plot_2 = @garden.plots.create!(number: 2, size: "Medium", direction: "West")
    @plot_3 = @garden.plots.create!(number: 3, size: "Medium", direction: "North")
    @hibiscus = Plant.create!(name: "Hibiscus", description: "Tropical Flower", days_to_harvest: 50)
    @corn = Plant.create!(name: "Corn", description: "Your basic corn", days_to_harvest: 105)
    @sage = Plant.create!(name: "Desert Sage", description: "The common and delicios desert sage", days_to_harvest: 36)
    @hops = Plant.create!(name: "Vine Hops", description: "Fast growing hops vine", days_to_harvest: 12)

    PlantPlot.create!(plant: @hibiscus, plot: @plot_1)
    PlantPlot.create!(plant: @corn, plot: @plot_1)
    PlantPlot.create!(plant: @sage, plot: @plot_1)
    PlantPlot.create!(plant: @hops, plot: @plot_2)
    PlantPlot.create!(plant: @hibiscus, plot: @plot_2)
    PlantPlot.create!(plant: @corn, plot: @plot_2)
    PlantPlot.create!(plant: @hibiscus, plot: @plot_3)
    PlantPlot.create!(plant: @hops, plot: @plot_3)
  end

  describe "As a visitor when I visit the garden's show page" do 
    it "displays a unique list of plants that included in that garden's plots which take less than 100 days to harvest and is sorted from most to least" do 
      visit garden_path(@garden)

      expect(page).to have_content("List of Plants Which Take Under 100 Days To Harvest:")
      expect("Hibiscus").to appear_before("Vine Hops")
      expect("Vine Hops").to appear_before("Desert Sage")
    end
  end
end