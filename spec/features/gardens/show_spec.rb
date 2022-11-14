require "rails_helper"


RSpec.describe("Garden show page") do
  before(:each) do
    @garden1 = Garden.create(    name: "Turing Community Garden",     organic: true)
    @plot1 = Plot.create!(    number: 25,     size: "Large",     direction: "East",     garden: @garden1)
    @plant1 = @plot1.plants.create!(    name: "Purple Beauty Sweet Bell Pepper",     description: "Prefers rich, well draining soil.",     days_to_harvest: 90)
    @plant2 = @plot1.plants.create!(    name: "Sunflower",     description: "well draining soil.",     days_to_harvest: 60)
    @plot2 = Plot.create!(    number: 20,     size: "Medium",     direction: "West",     garden: @garden1)
    @plant1 = @plot2.plants.create!(    name: "Purple Beauty Sweet Bell Pepper",     description: "Prefers rich, well draining soil.",     days_to_harvest: 90)
    @plant3 = @plot2.plants.create!(    name: "Rose",     description: "Prefers rich",     days_to_harvest: 100)
    @plot3 = Plot.create!(    number: 15,     size: "Small",     direction: "South",     garden: @garden1)
    @plant4 = @plot3.plants.create!(    name: "Lily",     description: "Prefers Sand",     days_to_harvest: 50)
  end

  describe("As a visitor When I visit a garden's show page") do
    it("Then I see a list of plants that are included in that garden's plots") do
      visit(garden_path(@garden1.id))
      expect(page).to(have_content(@plant1.name))
      expect(page).to(have_content(@plant2.name))
      expect(page).to(have_content(@plant3.name))
      expect(page).to(have_content(@plant4.name))
    end
  end
end
