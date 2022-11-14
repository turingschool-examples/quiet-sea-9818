require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe 'instance methods' do
    before :each do
      @garden_1 = Garden.create!(name: 'Salad Garden', organic: true)
      @garden_2 = Garden.create!(name: 'Experimental Garden', organic: false)
      @plot_1 = @garden_1.plots.create!(number: 1, size: 'Large', direction: 'East')
      @plot_2 = @garden_1.plots.create!(number: 14, size: 'Small', direction: 'South')
      @plot_3 = @garden_1.plots.create!(number: 21, size: 'Medium', direction: 'West')
      @plot_4 = @garden_2.plots.create!(number: 6, size: 'Medium', direction: 'East')

      @plant_1 = @plot_1.plants.create!(name: 'Cherry Tomato', description: 'Bears small, sweet tomatoes.', days_to_harvest: 90)
      @plant_2 = @plot_1.plants.create!(name: 'Green Bell Pepper', description: 'Medium sized bell peppers.', days_to_harvest: 80)
      @plant_3 = @plot_2.plants.create!(name: 'Cabbage', description: 'Leafy green.', days_to_harvest: 120)
      @plant_4 = @plot_4.plants.create!(name: 'Kale', description: 'Extra frilly.', days_to_harvest: 80)
      
      @plant_plot = PlantPlot.create!(plot_id: @plot_3.id, plant_id: @plant_1.id)
    end
    describe '.garden_plants' do
      it 'returns names of all unique plants in a garden' do
        expect(@garden_1.garden_plants).to eq(['Cherry Tomato', 'Green Bell Pepper'])
      end
    end
  end
end
