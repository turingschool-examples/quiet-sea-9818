require 'rails_helper'

RSpec.describe 'plots index page' do

  before :each do 
    @secret_garden = Garden.create!(name: "Secret Garden", organic: true)
    @plot1 = @secret_garden.plots.create!(number: 25, size: "Large", direction: "East")
    @plot2 = @secret_garden.plots.create!(number: 10, size: "Medium", direction: "West")
    @plot3 = @secret_garden.plots.create!(number: 18, size: "Large", direction: "East")

    
    @purple = @plot1.plants.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    @lily = @plot1.plants.create!(name: "Lily", description: "Very pretty.", days_to_harvest: 60)
    @tree = @plot1.plants.create!(name: "Tree", description: "Not very pretty.", days_to_harvest: 50)
    @lily = @plot2.plants.create!(name: "Lily", description: "Very pretty.", days_to_harvest: 60)
    @tree = @plot3.plants.create!(name: "Tree", description: "Not very pretty.", days_to_harvest: 50)
    @venus_flytrap = @plot3.plants.create!(name: "Venus Flytrap", description: "Very Ugly", days_to_harvest: 50)

  end

  describe 'as a visitor on plots index' do 
    it 'i see list of all plot numbers and names of all of that plots plants' do 
      visit plots_path
      within "#plot-#{@plot1.id}" do 
        expect(page).to have_content("Plot Number: 25")
        expect(page).to have_content("Plants:") 
        expect(page).to have_content("Purple Beauty Sweet Bell Pepper")
        expect(page).to have_content("Lily")
        expect(page).to have_content("Tree")
        expect(page).to_not have_content("Venus Flytrap")
      end

      within "#plot-#{@plot2.id}" do 
        expect(page).to have_content("Plot Number: 10")
        expect(page).to_not have_content("Plot Number: 25")
        expect(page).to have_content("Plants:") 
        expect(page).to have_content("Lily")
        expect(page).to_not have_content("Tree")
      end
    end
  end 


end