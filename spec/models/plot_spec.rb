require 'rails_helper'

RSpec.describe Plot do
  describe 'relationships' do
    it { should belong_to(:garden) }
    it { should have_many :plant_plots }
    it { should have_many(:plants).through(:plant_plots) }
  end

  before(:each) do
    garden_1 = Garden.create(name: "Garden1", organic: true)
    @plot_1 = garden_1.plots.create(number: 1, size: 'small', direction: 'north')
    @plant_1 = @plot_1.plants.create(name: 'plant1', description: 'a plant', days_to_harvest: 99)
    @plant_2 = @plot_1.plants.create(name: 'plant2', description: 'also here', days_to_harvest: 1)
  end
end
