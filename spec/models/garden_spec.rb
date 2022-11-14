require 'rails_helper'

RSpec.describe Garden do
  before(:each) do
    @garden1 = Garden.create!(name: 'Turing Community Garden', organic: true)

    @plot1 = @garden1.plots.create!(number: 25, size: 'Large', direction: 'East')
    @plot2 = @garden1.plots.create!(number: 26, size: 'Medium', direction: 'West')

    @shared_plant = Plant.create!(name: 'shared plant', description: 'its dope', days_to_harvest: 5)

    @plant1 = @plot1.plants.create!(name: 'Red Beauty Sweet Bell Pepper',
                                    description: 'Prefers rich, well draining soil.', days_to_harvest: 90)
    @plant2 = @plot1.plants.create!(name: 'Orange pumpkins', description: 'Prefers dry soil.', days_to_harvest: 200)
    @plant3 = @plot1.plants.create!(name: 'Yellow Corn', description: 'soil.', days_to_harvest: 20)

    @plant4 = @plot2.plants.create!(name: 'Green Beans', description: 'Fertilizer', days_to_harvest: 600)
    @plant5 = @plot2.plants.create!(name: 'Blue Corn', description: 'Prefers sand', days_to_harvest: 60)
    @plant6 = @plot2.plants.create!(name: 'Indigo Bell Pepper', description: 'Prefers rocks', days_to_harvest: 490)

    @plot1.plants << @shared_plant
    @plot2.plants << @shared_plant
  end

  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plant_plots).through(:plots) }
    it { should have_many(:plants).through(:plant_plots) }
  end

  describe 'instance methods' do
    describe '#unique_plants' do
      it 'only returns unique plants' do
        expect(@garden1.unique_plants.count).to eq(4)
      end
    end
  end
end
