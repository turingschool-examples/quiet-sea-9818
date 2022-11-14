require 'rails_helper'

RSpec.describe PlotPlant do
  describe 'relationships' do
    it { should belong_to(:plot) }
    it { should belong_to(:plant) }
  end
  
  before :each do
    @eden = Garden.create(name:"Eden", organic: true)
    @plot1 = Plot.create(number: 1, size: "Large", direction: "East", garden_id: @eden.id)
    @plot2 = Plot.create(number: 2, size: "Large", direction: "West", garden_id: @eden.id)
    @tomato = Plant.create(name: "Tomato", description: "Likes sun", days_to_harvest: 110)
    @zucchini = Plant.create(name: "Zucchini", description: "Only good in bread", days_to_harvest: 90)
    @squash = Plant.create(name: "Squash", description: "Does anyone even eat this?", days_to_harvest: 85)
    
    @plot_1_tomato = PlotPlant.create(plot_id: @plot1.id, plant_id: @tomato.id)
    # @plot1.plants << @tomato
    @plot1.plants << @zucchini
    @plot2.plants << @squash
    @plot2.plants << @tomato
  end
  
  describe 'class methods' do
    describe '#find_by_foreign_keys' do
      it "returns the plot_plant at the intersection of the foreign keys" do
        expect(PlotPlant.find_by_foreign_keys(@plot1.id, @tomato.id)).to eq(@plot_1_tomato)
      end
    end
  end
end