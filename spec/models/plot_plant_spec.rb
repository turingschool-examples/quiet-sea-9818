require 'rails_helper'

RSpec.describe PlotPlant do
  describe 'relationships' do
    it { should belong_to(:plot)}
    it { should belong_to(:plant)}
  end

  before(:each) do
    @garden = Garden.create!(name: "Family Farm", organic: true)
    
    @plot_1 = @garden.plots.create!(number: 1, size: "medium", direction: "Sout West")
    @plot_2 = @garden.plots.create!(number: 2, size: "small", direction: "North")
    @plot_3 = @garden.plots.create!(number: 3, size: "large", direction: "North East")
    @plot_4 = @garden.plots.create!(number: 4, size: "medium", direction: "West")

    @plant_1 = Plant.create!(name: "Watermelon", description: "Juicy fruit", days_to_harvest: 30)
    @plant_2 = Plant.create!(name: "Cucumber", description: "Refreshing snack", days_to_harvest: 14)
    @plant_3 = Plant.create!(name: "Tomato", description: "Red and delicious", days_to_harvest: 18)
    @plant_4 = Plant.create!(name: "Corn", description: "Sweet vegetable", days_to_harvest: 60)
    @plant_5 = Plant.create!(name: "Strawberry", description: "Sweet snack", days_to_harvest: 105)
    @plant_6 = Plant.create!(name: "Pumpkin", description: "Great for Jack-o-lanters", days_to_harvest: 110)

    @pp_1 = PlotPlant.create!(plot: @plot_1, plant: @plant_1)
    @pp_2 = PlotPlant.create!(plot: @plot_1, plant: @plant_2)
    @pp_3 = PlotPlant.create!(plot: @plot_1, plant: @plant_3)
    
    @pp_4 = PlotPlant.create!(plot: @plot_2, plant: @plant_4)
    @pp_5 = PlotPlant.create!(plot: @plot_2, plant: @plant_5)

    @pp_6 = PlotPlant.create!(plot: @plot_3, plant: @plant_1)

    @pp_7 = PlotPlant.create!(plot: @plot_4, plant: @plant_5)
    @pp_8 = PlotPlant.create!(plot: @plot_4, plant: @plant_6)
  end

  describe 'class methods' do
    describe '#find_plot_plant' do
      it 'finds a plot_plant' do
        expect(PlotPlant.find_plot_plant(@plant_1, @plot_1)).to eq(@pp_1)
      end
    end
  end
end