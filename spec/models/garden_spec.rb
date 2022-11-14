require "rails_helper"


RSpec.describe(Garden) do
  describe("relationships") do
    it { should(have_many(:plots)) }
  end

  before(:each) do
    @garden1 = Garden.create(    name: "Turing Community Garden",     organic: true)
    @plot1 = Plot.create!(    number: 25,     size: "Large",     direction: "East",     garden: @garden1)
    @plant1 = @plot1.plants.create!(    name: "Purple Beauty Sweet Bell Pepper",     description: "Prefers rich, well draining soil.",     days_to_harvest: 90)
    @plant2 = @plot1.plants.create!(    name: "Sunflower",     description: "well draining soil.",     days_to_harvest: 60)
    @plot2 = Plot.create!(    number: 20,     size: "Medium",     direction: "West",     garden: @garden1)
    @plant1 = @plot2.plants.create!(    name: "Purple Beauty Sweet Bell Pepper",     description: "Prefers rich, well draining soil.",     days_to_harvest: 90)
    @plant3 = @plot2.plants.create!(    name: "Rose",     description: "Prefers rich",     days_to_harvest: 101)
    @plot3 = Plot.create!(    number: 15,     size: "Small",     direction: "South",     garden: @garden1)
    @plant4 = @plot3.plants.create!(    name: "Lily",     description: "Prefers Sand",     days_to_harvest: 50)
  end

  it("has plants with < 100 days to harvest") do
    expect(@garden1.harvest_less_than_100).to(eq(["Lily", "Purple Beauty Sweet Bell Pepper", "Sunflower"]))
  end
end
