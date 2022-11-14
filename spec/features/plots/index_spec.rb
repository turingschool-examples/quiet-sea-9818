require "rails_helper"

RSpec.describe "Plots Index Page" do
  before :each do
    @garden_1 = Garden.create!(name: "Turing Community Garden", organic: true)
    @plot_1 = @garden_1.plots.create!(number: 25, size: "Large", direction: "East")
    @plot_2 = @garden_1.plots.create!(number: 26, size: "Medium", direction: "North")
    @plot_3 = @garden_1.plots.create!(number: 27, size: "Small", direction: "West")
    @plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefer Rich", days_to_harvest: 90)
    @plant_2 = Plant.create!(name: "Red Beauty", description: "Prefer Poor", days_to_harvest: 30)
    @plant_3 = Plant.create!(name: "Blue Beauty", description: "Prefer Average", days_to_harvest: 45)
    @plot_plant_1 = PlotPlant.create(plot: @plot_1, plant: @plant_1)
    @plot_plant_2 = PlotPlant.create(plot: @plot_2, plant: @plant_2)
    @plot_plant_3 = PlotPlant.create(plot: @plot_3, plant: @plant_3)
  end

  it "sees a list of all plot numbers" do
    visit '/plots'
    expect(page).to have_content("Plots Index")
    expect(page).to have_content("Plot: #{@plot_1.number}")
    expect(page).to have_content("Plot: #{@plot_2.number}")
    expect(page).to have_content("Plot: #{@plot_3.number}")
  end

  it "under each plot number I see the name o fall the plot's plants" do
    visit '/plots'
    expect(page).to have_content("Plant: #{@plant_1.name}")
    expect(page).to have_content("Plant: #{@plant_2.name}")
    expect(page).to have_content("Plant: #{@plant_3.name}")
  end

  it "sees a link to remove plant from plot" do
    visit '/plots'
    expect(page).to have_content(@plant_1.name)
    click_link "Remove #{@plant_1.name}"
    expect(current_path).to eq("/plots")
    expect(page).to_not have_content(@plant_1.name)
    click_link "Remove #{@plant_2.name}"
    expect(page).to_not have_content(@plant_2.name)
  end
end
