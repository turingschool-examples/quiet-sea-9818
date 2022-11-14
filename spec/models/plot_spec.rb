require 'rails_helper'

RSpec.describe Plot do
  describe 'relationships' do
    it { should belong_to(:garden) }
    it { should have_many :plant_plots }
    it { should have_many(:plants).through(:plant_plots) }
  end

  describe 'instance methods' do
    before :each do
      @garden = Garden.create!(name: 'Salad Garden', organic: true)
      @plot = @garden.plots.create!(number: 1, size: 'Large', direction: 'East')
      @plant = Plant.create!(name: 'Cherry Tomato', description: 'Bears small, sweet tomatoes.', days_to_harvest: 90)
      @plant_plot = PlantPlot.create!(plot_id: @plot.id, plant_id: @plant.id)
    end
    describe '.plant_plot_id()' do
      it 'returns the id of the plant plot that binds the plant and plot' do
        expect(@plot.plant_plot_id(@plant)).to eq(@plant_plot.id)
      end
    end
  end
end
