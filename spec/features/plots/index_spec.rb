
# When I visit the plots index page ('/plots')#
# I see a list of all plot numbers
# And under each plot number I see the names of all that plot's plants

require 'rails_helper'

RSpec.describe 'plots index' do
  it 'has a list of plot numbers, with the names of all of their plots' do
    garden1 = Garden.create!(name: "Moms", organic: true)
    garden2 = Garden.create!(name: "Nannies", organic: false)

    plot1 = Plot.create!(number: 1, size: "1 Acre", direction: "North", garden_id: garden1.id)
    plot2 = Plot.create!(number: 2, size: "2 Acres", direction: "East", garden_id: garden1.id)
    plot3 = Plot.create!(number: 3, size: "3 Acres", direction: "South", garden_id: garden1.id)
    plot4 = Plot.create!(number: 4, size: "4 Acres", direction: "West", garden_id: garden2.id)

    plant1 = Plant.create!(name: "apple", description: "gala", days_to_harvest: 50)
    plant2 = Plant.create!(name: "pumpkin", description: "white", days_to_harvest: 25)
    plant3 = Plant.create!(name: "rasberry", description: "sweet", days_to_harvest: 75)
    plant4 = Plant.create!(name: "squash", description: "butternut", days_to_harvest: 100)

    plot_plant1 = PlotPlant.create!(plot_id: plot1.id, plant_id: plant1.id)
    plot_plant2 = PlotPlant.create!(plot_id: plot1.id, plant_id: plant2.id)
    plot_plant4 = PlotPlant.create!(plot_id: plot2.id, plant_id: plant3.id)
    plot_plant5 = PlotPlant.create!(plot_id: plot2.id, plant_id: plant4.id)
    # require 'pry'; binding.pry

    visit plots_path
    expect(current_path).to eq('/plots')
    within "#plot-#{plot1.number}" do
      expect(page).to have_content("apple")
      expect(page).to have_content("gala")
      expect(page).to have_content("pumpkin")
      expect(page).to have_content("white")
      expect(page).to_not have_content("butternut")
    end

    within "#plot-#{plot2.number}" do
      expect(page).to have_content("rasberry")
      expect(page).to have_content("sweet")
      expect(page).to have_content("squash")
      expect(page).to have_content("butternut")
      expect(page).to_not have_content("apple")
    end
  end
end
