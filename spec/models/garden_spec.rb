require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }

  end


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

  end

  describe 'model methods' do 
    it 'returns list of unique plants in a garden for plants that take less than 100 days' do 
      expect(@secret_garden.plant_order.pluck(:name)).to eq([@lily.name, @purple.name, @venus_flytrap.name])
      expect(@secret_garden.plant_order.pluck(:name)).to_not eq([@tree.name])

      expect(@weeds.plant_order.pluck(:name)).to eq([@dill.name])
      expect(@weeds.plant_order.pluck(:name)).to_not eq([@lily.name, @purple.name, @venus_flytrap.name])

    end

    it 'plant list is sorted by number of plants that appear in any of that gardens plots descending' do 

      expect(@secret_garden.plant_order.pluck(:name)).to eq(["Lily", "Purple Beauty Sweet Bell Pepper", "Venus Flytrap"])
    end
  end
end
