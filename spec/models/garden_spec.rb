require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants) }
  end
  
  before(:each) do 
    @garden1 = Garden.create!(name: 'Elitch Gardens', organic: false)
    @garden2 = Garden.create!(name: 'La Alma Community Garden', organic: true)

    @plot1 = @garden1.plots.create!(number: 25, size: 'Large', direction: 'East')
    @plot2 = @garden1.plots.create!(number: 10, size: 'Small', direction: 'West')
    @plot3 = @garden2.plots.create!(number: 10, size: 'Small', direction: 'West')
    @plot4 = @garden1.plots.create!(number: 10, size: 'Small', direction: 'West')

    @plant1 = Plant.create!(name: 'Doom Pepper', description: 'Spicy as hell', days_to_harvest: 140)
    @plant2 = Plant.create!(name: 'Happy Carrots', description: 'They so cute', days_to_harvest: 80)
    @plant3 = Plant.create!(name: 'Corn', description: 'A big lump with knobs', days_to_harvest: 90)
    @plant4 = Plant.create!(name: 'Rainbow Tomatoes', description: 'Theyre magically delicious', days_to_harvest: 20)
    @plant5 = Plant.create!(name: 'Giant Pumpkin', description: 'Cinderella better watch out', days_to_harvest: 20)

    @plot1.plants << @plant1 << @plant2
    @plot2.plants << @plant2 << @plant3 << @plant4
    @plot3.plants << @plant5 << @plant3
  end

  describe 'instance methods' do 
    describe '#plants_under_100_days' do 
      it 'returns unique plants in garden that harvest in less than 100 days' do 
        expect(@garden1.plants_under_100_days).to eq([@plant2, @plant3, @plant4])
        expect(@garden2.plants_under_100_days).to eq([@plant3, @plant5])
      end

      it 'is ordered by the number of times that plant appears in gardens plots' do 
        @plant3.plots << @plot1 << @plot4

        expect(@garden1.plants_under_100_days).to eq([@plant3, @plant2, @plant4])
      end
    end
  end
end
