require 'rails_helper'

RSpec.describe 'gardens show page' do

  before :each do 
    @secret_garden = Garden.create!(name: "Secret Garden", organic: true)

    @plot1 = @secret_garden.plots.create!(number: 25, size: "Large", direction: "East")
    @plot2 = @secret_garden.plots.create!(number: 10, size: "Medium", direction: "West")
    @plot3 = @secret_garden.plots.create!(number: 18, size: "Large", direction: "East")
    

    
    @purple = @plot1.plants.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    @lily = @plot1.plants.create!(name: "Lily", description: "Very pretty.", days_to_harvest: 60)
    @tree = @plot1.plants.create!(name: "Tree", description: "Not very pretty.", days_to_harvest: 150)
    @lily = @plot2.plants.create!(name: "Lily", description: "Very pretty.", days_to_harvest: 60)
    @tree = @plot3.plants.create!(name: "Tree", description: "Not very pretty.", days_to_harvest: 150)
    @venus_flytrap = @plot3.plants.create!(name: "Venus Flytrap", description: "Very Ugly", days_to_harvest: 50)
    
    @weeds = Garden.create!(name: "Weeds", organic: false)
    @plot4 = @weeds.plots.create!(number: 2, size: "small", direction: "East")
    @dill = @plot4.plants.create!(name: "Dill", description: "Dill is a weed.", days_to_harvest: 90)
    @tree = @plot4.plants.create!(name: "Tree", description: "Not very pretty.", days_to_harvest: 150)
    @dill = @plot4.plants.create!(name: "Dill", description: "Dill is a weed.", days_to_harvest: 90)
    @flower = @plot4.plants.create!(name: "Flower", description: "Cool plant.", days_to_harvest: 60)

  end

  describe 'as a visitor to garden show page' do 
    it 'i see a list of plants included in that gardens plots, this list is unique, and only includes plants that take less than 100 days to harvest' do 
      visit garden_path(@secret_garden)
      expect(page).to have_content("Plants That Harvest in Under 100 Days:")
      expect(page).to have_content("Venus Flytrap")
      expect(page).to have_content("Purple Beauty Sweet Bell Pepper")
      expect(page).to have_content("Lily")


      expect(page).to_not have_content("Tree")
      expect(page).to_not have_content("Dill")

      visit garden_path(@weeds)
      expect(page).to have_content("Plants That Harvest in Under 100 Days:")
      expect(page).to have_content("Dill")
      expect(page).to_not have_content("Tree")
      expect(page).to_not have_content("Lily Purple Beauty Sweet Bell Pepper Venus Flytrap")
    end

    it 'plant list is sorted by number of plants that appear in any of that gardens plots descending' do 
      visit garden_path(@secret_garden)
      expect("Lily").to appear_before("Purple")
      expect("Venus").to_not appear_before("Lily")
      expect(page).to_not have_content("Tree")
      save_and_open_page


      visit garden_path(@weeds)
      expect("Dill").to appear_before("Flower")
      expect("Flower").to_not appear_before("Dill")
      expect(page).to_not have_content("Tree")

    end
  end

end