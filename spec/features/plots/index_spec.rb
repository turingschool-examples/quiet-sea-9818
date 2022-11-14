require 'rails_helper'

RSpec.describe 'Plots Index Page' do 
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
    
    visit "/plots"
  end

  describe 'when i visit plot index page' do 
    it 'I see a list of all plot numbers' do 
      expect(page).to have_content(@plot1.number)
      expect(page).to have_content(@plot2.number)
      # save_and_open_page
    end

    it 'And under each plot number I see the names of all that plots plants' do
      expect(page).to have_content(@plant1.name)
      expect(page).to have_content(@plant2.name)
      expect(page).to have_content(@plant3.name)
      expect(page).to have_content(@plant4.name)
      expect(page).to have_content(@plant5.name)
      expect(page).to have_content(@plant6.name)
    end

    it 'i see a link to remove that plant from the plot' do 
      expect(page).to have_link("Delete #{@plant1.name}")

      click_link "Delete #{@plant1.name}"
      expect(current_path).to eq("/plots")
      save_and_open_page
    end
  end 
end