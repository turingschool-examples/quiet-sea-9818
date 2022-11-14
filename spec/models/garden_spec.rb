require 'rails_helper'

RSpec.describe Garden do
  before :each do 
    @garden1 = Garden.create!(name: 'Fungi Utopia', organic: true)
    @garden2 = Garden.create!(name: 'No Fun', organic: true)

    @plot1 = @garden1.plots.create!(number: 5, size: "Small", direction: "North")
    @plot2 = @garden1.plots.create!(number: 4, size: "Medium", direction: "South")

    @plant1 = @plot1.plants.create!(name: "Trippy", description: "out of this world", days_to_harvest: 45)
    @plant2 = @plot1.plants.create!(name: "Mario", description: "makes you want to eat", days_to_harvest: 50)
    @plant3 = @plot1.plants.create!(name: "Astroworld", description: "If you feel like raging", days_to_harvest: 55)
    @plant4 = @plot2.plants.create!(name: "Bumblebee", description: "chase your blues away", days_to_harvest: 60)
    @plant5 = @plot2.plants.create!(name: "Nightshade", description: "Makes you sleep", days_to_harvest: 65)
    @plant6 = @plot2.plants.create!(name: "No Dust Left Behind", description: "for to-do lists", days_to_harvest: 70)
  end

  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  it 'returns list of plant names in garden' do 
    expect(@garden1.garden_plants).to eq([@plant1, @plant2, @plant3, @plant4, @plant5, @plant6])
  end
end
