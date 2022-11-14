require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end
  before(:each) do
    @garden_1 = Garden.create(name: "Garden1", organic: true)
    @plot_1 = @garden_1.plots.create(number: 1, size: 'small', direction: 'north')
    @plant_1 = @plot_1.plants.create(name: 'plant1', description: 'a plant', days_to_harvest: 100)
    @plant_2 = @plot_1.plants.create(name: 'plant2', description: 'also here', days_to_harvest: 1)

    @plot_2 = @garden_1.plots.create(number: 2, size: 'small(ish)', direction: 'north north west')
    @plot_2.plants << @plant_2
    @plant_3 = @plot_2.plants.create(name: 'plant3', description: 'also here', days_to_harvest: 1)
  end
  describe 'instance methods' do
    describe '#garden_plants' do
      it 'returns distinct list of plants in that garden with under 100 days to harvest' do
        expect(@garden_1.garden_plants[0].name).to eq(@plant_2.name)
        expect(@garden_1.garden_plants[1].name).to eq(@plant_3.name)
      end
    end
  end
end
