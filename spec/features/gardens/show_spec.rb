# User Story 3, Garden's Plants
# As a visitor
# When I visit a garden's show page
# Then I see a list of plants that are included in that garden's plots
# And I see that this list is unique (no duplicate plants)
# And I see that this list only includes plants that take less than 100 days to harvest
require 'rails_helper'

RSpec.describe "Garden Show Page" do
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

  describe "As a visitor" do
    describe "When I visit a garden's show page" do
      it "Then I see a UNIQUE list of plants that are included in that garden's plots that take less than 100 days to harvest" do
        visit "/gardens/#{@garden.id}"
        # save_and_open_page
        expect(page).to have_content("Turing Community Garden")
        expect(page).to have_content("Plants: Plant1, Plant2, Plant3")
      end
    end
  end
end
