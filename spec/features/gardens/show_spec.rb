require 'rails_helper'

RSpec.describe 'Garden Show' do
  
  before :each do
    @eden = Garden.create(name:"Eden", organic: true)
    @secret_garden = Garden.create(name:"The Secret Garden", organic: true)
    
    @plot1 = Plot.create(number: 1, size: "Large", direction: "East", garden_id: @eden.id)
    @plot2 = Plot.create(number: 2, size: "Large", direction: "West", garden_id: @eden.id)
    @secret_garden_plot = Plot.create(number: 2, size: "Large", direction: "West", garden_id: @secret_garden.id)
    @tomato = Plant.create(name: "Tomato", description: "Likes sun", days_to_harvest: 110)
    @zucchini = Plant.create(name: "Zucchini", description: "Only good in bread", days_to_harvest: 90)
    @squash = Plant.create(name: "Squash", description: "Does anyone even eat this?", days_to_harvest: 85)
    @potatoes = Plant.create(name: "Pumpkin", description: "Boil 'em, Mash 'em, stick 'em in a stew", days_to_harvest: 85)
    
    @plot1.plants << @tomato
    @plot1.plants << @zucchini
    @plot2.plants << @zucchini
    @plot2.plants << @squash
    @plot2.plants << @tomato
    @secret_garden_plot.plants << @squash
    
    visit "/gardens/#{@eden.id}"
  end
  
  describe 'as a visitor' do
    it "I see a list of plants that are included in that garden's plots. I see
    that this list is unique (no duplicate plants), And I see that this list
    only includes plants that take less than 100 days to harvest" do
      within("#garden-plants") do
        expect(page).to have_content(@zucchini.name)
        expect(page).to have_content(@squash.name)
        expect(page).to_not have_content(@tomato.name)
        expect(page).to_not have_content(@potatoes.name)
      end
    end
    it "I see the list of plants is sorted by the number of plants that appear
    in any of that garden's plots from most to least" do
      within("#garden-plants") do
        expect(@zucchini.name).to appear_before(@squash.name)
      end
    end
  end
end