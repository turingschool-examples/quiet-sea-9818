require 'rails_helper'

RSpec.describe PlotPlant do
  describe 'relationships' do
    it { should belong_to(:plot) }
    it { should belong_to(:plant) }
  end

  describe 'methods' do
    before :each do
      @garden_1 = Garden.create!(name: "Botanical Gardens", organic: true)
      @plot_1 = @garden_1.plots.create!(number: 1, size: "Large", direction: "East")
      @plot_2 = @garden_1.plots.create!(number: 2, size: "Medium", direction: "North")
      @plot_3 = @garden_1.plots.create!(number: 3, size: "Medium", direction: "West")
      @plant_1 = Plant.create!(name: "Lily", description: "Ummm?")
      @plot_plant_1 = PlotPlant.create(plot_id: @plot_1.id, plant_id: @plant_1.id)
      @plot_plant_3 = PlotPlant.create(plot_id: @plot_3.id, plant_id: @plant_1.id)
      @plant_2 = @plot_1.plants.create!(name: "Lotus", description: "Floatato?")
      @plant_3 = @plot_1.plants.create!(name: "Daisy", description: "Ermmm?")
      @plant_4 = @plot_2.plants.create!(name: "Dahlia", description: "With an h!")
      @plant_5 = @plot_2.plants.create!(name: "Apricot", description: "Yum!")
      @plant_6 = @plot_3.plants.create!(name: "Birch", description: "I see in a lot of video games?")
      @plant_7 = @plot_3.plants.create!(name: "Rose", description: "Red?")
    end

    describe '#find_by_plant_and_plot_ids' do
      it 'finds the record matching the plant and plot ids provided' do
        expect(PlotPlant.find_by_plant_and_plot_ids(@plot_1.id, @plant_1.id).first).to eq(@plot_plant_1)
      end
    end
  end
end