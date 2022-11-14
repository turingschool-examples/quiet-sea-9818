require 'rails_helper'

RSpec.describe 'garden show page' do 
  before :each do 
    @garden1 = Garden.create!(name: 'Fungi Utopia', organic: true)
    @garden2 = Garden.create!(name: 'No Fun', organic: true)

    @plot1 = @garden1.plots.create!(number: 5, size: "Small", direction: "North")
    @plot2 = @garden1.plots.create!(number: 4, size: "Medium", direction: "South")

    @plant1 = @plot1.plants.create!(name: "Trippy", description: "out of this world", days_to_harvest: 45)
    @plant2 = @plot1.plants.create!(name: "Mario", description: "makes you want to eat", days_to_harvest: 50)
    @plant3 = @plot1.plants.create!(name: "Astroworld", description: "If you feel like raging", days_to_harvest: 55)
    @plant4 = @plot2.plants.create!(name: "Bumblebee", description: "chase your blues away", days_to_harvest: 60)
    @plant5 = @plot2.plants.create!(name: "Nightshade", description: "Makes you sleep", days_to_harvest: 65)
    @plant6 = @plot2.plants.create!(name: "No Dust Left Behind", description: "for to-do lists", days_to_harvest: 70)
    
    visit "/gardens/:id"
  end

  describe 'when I visit a gardens show page' do 
    it 'see a list of plants that are included in that gardens plots' do 
      expect(page).to have_content(@plant1.name)
    end
  end
end 