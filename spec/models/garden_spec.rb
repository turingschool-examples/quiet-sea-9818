require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  describe 'validations' do
    it { should validate_presence_of :name}
  end

  before(:each) do
    @garden_1 = Garden.create!(name: "Family Farm", organic: true)
    @garden_2 = Garden.create!(name: "Fran's Farm", organic: false)
    
    @plot_1 = @garden_1.plots.create!(number: 1, size: "medium", direction: "Sout West")
    @plot_2 = @garden_1.plots.create!(number: 2, size: "small", direction: "North")
    @plot_3 = @garden_1.plots.create!(number: 3, size: "large", direction: "North East")
    @plot_4 = @garden_1.plots.create!(number: 4, size: "medium", direction: "West")
    @plot_5 = @garden_2.plots.create!(number: 45, size: "Extra large", direction: "South")

    @plant_1 = Plant.create!(name: "Watermelon", description: "Juicy fruit", days_to_harvest: 30)
    @plant_2 = Plant.create!(name: "Cucumber", description: "Refreshing snack", days_to_harvest: 14)
    @plant_3 = Plant.create!(name: "Tomato", description: "Red and delicious", days_to_harvest: 18)
    @plant_4 = Plant.create!(name: "Corn", description: "Sweet vegetable", days_to_harvest: 60)
    @plant_5 = Plant.create!(name: "Strawberry", description: "Sweet snack", days_to_harvest: 105)
    @plant_6 = Plant.create!(name: "Pumpkin", description: "Great for Jack-o-lanters", days_to_harvest: 110)

    PlotPlant.create!(plot: @plot_1, plant: @plant_1)
    PlotPlant.create!(plot: @plot_1, plant: @plant_2)
    PlotPlant.create!(plot: @plot_1, plant: @plant_3)

    PlotPlant.create!(plot: @plot_2, plant: @plant_3)
    PlotPlant.create!(plot: @plot_2, plant: @plant_4)
    PlotPlant.create!(plot: @plot_2, plant: @plant_5)

    PlotPlant.create!(plot: @plot_3, plant: @plant_1)
    PlotPlant.create!(plot: @plot_3, plant: @plant_3)

    PlotPlant.create!(plot: @plot_4, plant: @plant_5)
    PlotPlant.create!(plot: @plot_4, plant: @plant_6)
    
    PlotPlant.create!(plot: @plot_5, plant: @plant_1)
    PlotPlant.create!(plot: @plot_5, plant: @plant_2)
  end

  describe 'instance methods' do
    describe '#list_garden_plants' do
      it 'returns a unique list of plants found in that garden that have less than 100 days to harvest' do
        expect(@garden_1.list_garden_plants).to eq([@plant_1, @plant_2, @plant_3, @plant_4])
      end
    end
  end

  # xdescribe 'class methods' do
  #   describe '#order_garden_plants' do
  #     it 'orders list of garden plants by number of occurences in plots' do
  #       expect(@garden_1.list_garden_plants.order_garden_plants).to eq([@plant_3, @plant_1, @plant_2, @plant_4])
  #     end
  #   end
  # end
end
