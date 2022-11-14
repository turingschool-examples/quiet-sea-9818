require 'rails_helper'

RSpec.describe 'gardens show page' do

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

  describe 'as a visitor to garden show page' do 
    it 'i see a list of plants included in that gardens plots, this list is unique, and only includes plants that take less than 100 days to harvest' do 
      visit garden_path(@secret_garden)
      require 'pry'; binding.pry
    end
  end

end