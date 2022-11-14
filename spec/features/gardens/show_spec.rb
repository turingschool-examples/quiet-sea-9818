require 'rails_helper'

RSpec.describe 'Garden show' do
  before :each do
    @garden1 = Garden.create!(name: "Moms", organic: true)
    @garden2 = Garden.create!(name: "Nannies", organic: false)

    @plot1 = Plot.create!(number: 1, size: "1 Acre", direction: "North", garden_id: @garden1.id)
    @plot2 = Plot.create!(number: 2, size: "2 Acres", direction: "East", garden_id: @garden1.id)
    @plot3 = Plot.create!(number: 3, size: "3 Acres", direction: "South", garden_id: @garden1.id)
    @plot4 = Plot.create!(number: 4, size: "4 Acres", direction: "West", garden_id: @garden2.id)

    @plant1 = Plant.create!(name: "apple", description: "gala", days_to_harvest: 50)
    @plant2 = Plant.create!(name: "pumpkin", description: "white", days_to_harvest: 25)
    @plant3 = Plant.create!(name: "rasberry", description: "sweet", days_to_harvest: 75)
    @plant4 = Plant.create!(name: "squash", description: "butternut", days_to_harvest: 100)
    @plant5 = Plant.create!(name: "apple", description: "gala", days_to_harvest: 50)

    @plot_plant1 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant1.id)
    @plot_plant2 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant2.id)
    @plot_plant4 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant3.id)
    @plot_plant5 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant4.id)
    
    # require 'pry'; binding.pry
  end
  
  describe 'Garden Show Page' do
#Then I see a list of plants that are included in that garden's plots
# And I see that this list is unique (no duplicate plants)
# And I see that this list only includes plants that take less than 100 days to harvest
    it'has a unique list of plants that are included in that gardens plots' do
    visit "/gardens/#{@garden1.id}"

    expect(page).to have_content("Moms")
    expect(page).to have_content([@plant1.name, @plant2.name, @plant3.name])
    expect(page).to_not have_content("Nannies")
    expect(page).to_not have_content([@plant4.name])

    end



  end
end