require 'rails_helper'

RSpec.describe 'Plot index page' do
  it 'lists all plot numbers with their respective plants beneath them' do
    garden_1 = Garden.create!(name: "Botanical Gardens", organic: true)
    plot_1 = garden_1.plots.create!(number: 1, size: "Large", direction: "East")
    plot_2 = garden_1.plots.create!(number: 2, size: "Medium", direction: "North")
    plot_3 = garden_1.plots.create!(number: 3, size: "Medium", direction: "West")
    plant_1 = plot_1.plants.create!(name: "Lily", description: "Ummm?")
    plant_2 = plot_1.plants.create!(name: "Lotus", description: "Floatato?")
    plant_3 = plot_1.plants.create!(name: "Daisy", description: "Ermmm?")
    plant_4 = plot_2.plants.create!(name: "Dahlia", description: "With an h!")
    plant_5 = plot_2.plants.create!(name: "Apricot", description: "Yum!")
    plant_6 = plot_3.plants.create!(name: "Birch", description: "I see in a lot of video games?")
    plant_7 = plot_3.plants.create!(name: "Rose", description: "Red?")
    

    visit plots_path

    expect(page).to have_content("Plots Index")
    expect(page).to have_content("Plot Number: 1")
    expect(page).to have_content("Plot 1 Plants:")
    expect(page).to have_content("Lily")
    expect(page).to have_content("Lotus")
    expect(page).to have_content("Daisy")
    expect(page).to have_content("Plot Number: 2")
    expect(page).to have_content("Plot 2 Plants:")
    expect(page).to have_content("Dahlia")
    expect(page).to have_content("Apricot")
    expect(page).to have_content("Plot Number: 3")
    expect(page).to have_content("Plot 3 Plants:")
    expect(page).to have_content("Birch")
    expect(page).to have_content("Rose")
  end
end