require "rails_helper"

RSpec.describe "Plots Index Page" do
  before :each do
    @garden_1 = Garden.create!(name: "Turing Community Garden", organic: true)
    @plot_1 = @garden_1.plots.create!(number: 25, size: "Large", direction: "East")
    @plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefer Rich", days_to_harvest: 90)
    visit '/plots'
  end

  it "sees a list of all plot numbers" do

  end
end
