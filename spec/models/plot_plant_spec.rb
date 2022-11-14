require 'rails_helper'

RSpec.describe PlotPlant do
  describe 'relationships' do
    it { should belong_to :plot }
    it { should belong_to :plant }
  end

  before :each do
    @turing = Garden.create!(name: "Turing Community Garden", organic: true)
    @plot1 = @turing.plots.create!(number: 25, size: "Large", direction: "East")
    @plot2 = @turing.plots.create!(number: 87, size: "Small", direction: "West")
    @pepper = Plant.create!(name: "Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    @potato = Plant.create!(name: "Yukon Gold", description: "Needs colder temps", days_to_harvest: 120)
    @kale = Plant.create!(name: "Dino Kale", description: "Alkaline soil needed", days_to_harvest: 50)
    @plotplant1 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @potato.id)
    @plotplant2 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @kale.id)
    @plotplant3 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @pepper.id)
  end

  describe 'model methods' do
    describe '#plant_name' do
      it 'returns the name of a plot plant' do
        expect(@plotplant1.plant_name).to eq(@potato.name)
        expect(@plotplant2.plant_name).to eq(@kale.name)
        expect(@plotplant3.plant_name).to eq(@pepper.name)
      end
    end
  end
end