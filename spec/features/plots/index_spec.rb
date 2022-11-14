require 'rails_helper'

RSpec.describe 'Plot Index' do
  describe 'As a visitor' do
    it "I see a list of all plot numbers And under each plot number I see the
    names of all that plot's plants" do
      eden = Garden.create(name:"Eden", organic: true)
      plot1 = Plot.create(number: 1, size: "Large", direction: "East", garden_id: eden.id)
      plot2 = Plot.create(number: 2, size: "Large", direction: "West", garden_id: eden.id)
      tomato = Plant.create(name: "Tomato", description: "Likes sun", days_to_harvest: 110)
      zucchini = Plant.create(name: "Zucchini", description: "Only good in bread", days_to_harvest: 90)
      squash = Plant.create(name: "Squash", description: "Does anyone even eat this?", days_to_harvest: 85)
      
      plot1.plants << tomato
      plot1.plants << zucchini
      plot2.plants << squash
      
      visit '/plots'
      
      within("#plots-plants") do
        expect(page).to have_content(plot1.number)
        expect(page).to have_content(tomato.name)
        expect(page).to have_content(zucchini.name)
        expect(page).to have_content(plot2.number)
        expect(page).to have_content(squash.name)
      end
    end
  end
end