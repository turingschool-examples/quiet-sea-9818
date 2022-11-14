require 'rails_helper'

RSpec.describe 'gardens show page' do
  before :each do
    @garden_1 = Garden.create!(name: "Botanical Gardens", organic: true)
    @plot_1 = @garden_1.plots.create!(number: 1, size: "Large", direction: "East")
    @plot_2 = @garden_1.plots.create!(number: 2, size: "Medium", direction: "North")
    @plot_3 = @garden_1.plots.create!(number: 3, size: "Medium", direction: "West")
    @plant_1 = Plant.create!(name: "Lily", description: "Ummm?", days_to_harvest: 99)
    @plot_1.plants << @plant_1
    @plot_3.plants << @plant_1
    @plant_2 = @plot_1.plants.create!(name: "Lotus", description: "Floatato?", days_to_harvest: 100)
    @plant_3 = @plot_1.plants.create!(name: "Daisy", description: "Ermmm?", days_to_harvest: 90)
    @plant_4 = @plot_2.plants.create!(name: "Dahlia", description: "With an h!", days_to_harvest: 80)
    @plant_5 = @plot_2.plants.create!(name: "Apricot", description: "Yum!", days_to_harvest: 70)
    @plant_6 = @plot_3.plants.create!(name: "Birch", description: "I see in a lot of video games?", days_to_harvest: 86)
    @plant_7 = @plot_3.plants.create!(name: "Rose", description: "Red?", days_to_harvest: 110)
  end

  it "displays a unique list of plants with harvest days under 100 in that garden's plots" do
    visit garden_path(@garden_1)

    save_and_open_page
    
    expect(page).to have_content("Plants with Harvest Days under 100:")
    expect(page).to have_content("Lily", count: 1) #there are two in the test to check duplication
    expect(page).to have_content("Daisy", count: 1)
    expect(page).to have_content("Dahlia", count: 1)
    expect(page).to have_content("Apricot", count: 1)
    expect(page).to have_content("Birch", count: 1)
    expect(page).to_not have_content("Lotus")
    expect(page).to_not have_content("Rose")
  end
end