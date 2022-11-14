require 'rails_helper'

RSpec.describe 'plot_plant destroy' do
  before :each do
    @garden_1 = Garden.create!(name: "Botanical Gardens", organic: true)
    @plot_1 = @garden_1.plots.create!(number: 1, size: "Large", direction: "East")
    @plot_2 = @garden_1.plots.create!(number: 2, size: "Medium", direction: "North")
    @plot_3 = @garden_1.plots.create!(number: 3, size: "Medium", direction: "West")
    @plant_1 = Plant.create!(name: "Lily", description: "Ummm?")
    @plot_1.plants << @plant_1
    @plot_3.plants << @plant_1
    @plant_2 = @plot_1.plants.create!(name: "Lotus", description: "Floatato?")
    @plant_3 = @plot_1.plants.create!(name: "Daisy", description: "Ermmm?")
    @plant_4 = @plot_2.plants.create!(name: "Dahlia", description: "With an h!")
    @plant_5 = @plot_2.plants.create!(name: "Apricot", description: "Yum!")
    @plant_6 = @plot_3.plants.create!(name: "Birch", description: "I see in a lot of video games?")
    @plant_7 = @plot_3.plants.create!(name: "Rose", description: "Red?")
  end

  it 'it removes a plot_plant record' do
    visit plots_path
    
    expect(page).to have_content("Lily", count: 2)
    expect(page).to have_button("Remove Lily", count: 2)

    within "#Plot-1-Plants" do
      click_button "Remove Lily"
    end

    expect(current_path).to eql(plots_path)
    expect(page).to have_content("Lily", count: 1)
    expect(page).to have_button("Remove Lily", count: 1)
  end
end