require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  describe 'instance methods' do 
    describe '#short_harvest_plants' do 
      it 'returns a unique list of plant names for a instance of Garden, sorted by quantity most to least' do 
        garden = Garden.create!(name: "Cole Neighborhood Garden", organic: false)
        plot_1 = garden.plots.create!(number: 1, size: "Large", direction: "East")
        plot_2 = garden.plots.create!(number: 2, size: "Medium", direction: "West")
        plot_3 = garden.plots.create!(number: 3, size: "Small", direction: "North")

        hibiscus = Plant.create!(name: "Hibiscus", description: "Tropical Flower", days_to_harvest: 50)
        corn = Plant.create!(name: "Corn", description: "Your basic corn", days_to_harvest: 106)
        sage = Plant.create!(name: "Desert Sage", description: "The common and delicios desert sage", days_to_harvest: 36)
        hops = Plant.create!(name: "Vine Hops", description: "Fast growing hops vine", days_to_harvest: 12)

        PlantPlot.create!(plant: hibiscus, plot: plot_1)
        PlantPlot.create!(plant: corn, plot: plot_1)
        PlantPlot.create!(plant: sage, plot: plot_1)
        PlantPlot.create!(plant: hops, plot: plot_2)
        PlantPlot.create!(plant: hibiscus, plot: plot_2)
        PlantPlot.create!(plant: corn, plot: plot_2)
        PlantPlot.create!(plant: hibiscus, plot: plot_3)
        PlantPlot.create!(plant: hops, plot: plot_3)

        expect(garden.short_harvest_plants).to eq(["Hibiscus", "Vine Hops", "Desert Sage"])

        apple = Plant.create!(name: "Apple", description: "Apple Tree", days_to_harvest: 80)
        tomato = Plant.create!(name: "Tomato", description: "Long harvest tomato plant", days_to_harvest: 150)
        PlantPlot.create!(plant: apple, plot: plot_1)
        PlantPlot.create!(plant: apple, plot: plot_2)
        PlantPlot.create!(plant: tomato, plot: plot_1)

        expect(garden.short_harvest_plants).to eq(["Hibiscus", "Vine Hops", "Apple", "Desert Sage"])
      end
    end
  end
end
