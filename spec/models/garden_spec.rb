require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  before(:each) do
    @my_garden = Garden.create!(name: "Kenz's Garden", organic: true)

    @plot_1 = Plot.create!(number: 1, size: "Small", direction: "West", garden_id: @my_garden.id)
    @plot_2 = Plot.create!(number: 2, size: "Medium", direction: "Southwest", garden_id: @my_garden.id)
    @plot_3 = Plot.create!(number: 3, size: "Large", direction: "North", garden_id: @my_garden.id)

    @strawberries = Plant.create!(name: "Summer Strawberries", description: "So Juicy & Delicious!", days_to_harvest: 180)
    @kale = Plant.create!(name: "Dino Kale", description: "Hardy & Versitile!", days_to_harvest: 60)
    @plums = Plant.create!(name: "Plum Tree", description: "Worth The Wait!", days_to_harvest: 250)
    @bananas = Plant.create!(name: "San Juan Banana Tree", description: "We don't know how they grow here either!", days_to_harvest: 45)
    @bell_peppers = Plant.create!(name: "Green Bell Peppers", description: "A Classic!", days_to_harvest: 100)

    @plot_1.plants << @strawberries
    @plot_1.plants << @plums
    @plot_2.plants << @kale
    @plot_2.plants << @strawberries
    @plot_2.plants << @bell_peppers
    @plot_3.plants << @bananas
    @plot_3.plants << @strawberries
  end

  describe '#instance methods' do
    describe '#uniq_plants_short_harvest' do
      it 'returns a unique list (no duplicates) of all of the plants in an instance 
      of garden that take less than 100 days to harvest' do
        expect(@my_garden.uniq_plants_short_harvest).to eq([@kale, @bananas])
      end
    end
  end
end
