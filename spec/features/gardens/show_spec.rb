require 'rails_helper'

RSpec.describe 'the garden index' do 
  before(:each) do 
    @garden1 = Garden.create!(name: 'Elitch Gardens', organic: false)
    @garden2 = Garden.create!(name: 'La Alma Community Garden', organic: true)

    @plot1 = @garden1.plots.create!(number: 25, size: 'Large', direction: 'East')
    @plot2 = @garden1.plots.create!(number: 10, size: 'Small', direction: 'West')
    @plot3 = @garden2.plots.create!(number: 10, size: 'Small', direction: 'West')

    @plant1 = Plant.create!(name: 'Doom Pepper', description: 'Spicy as hell', days_to_harvest: 140)
    @plant2 = Plant.create!(name: 'Happy Carrots', description: 'They so cute', days_to_harvest: 80)
    @plant3 = Plant.create!(name: 'Corn', description: 'A big lump with knobs', days_to_harvest: 90)
    @plant4 = Plant.create!(name: 'Rainbow Tomatoes', description: 'Theyre magically delicious', days_to_harvest: 20)
    @plant5 = Plant.create!(name: 'Giant Pumpkin', description: 'Cinderella better watch out', days_to_harvest: 20)

    @plot1.plants << @plant1 << @plant2
    @plot2.plants << @plant2 << @plant3 << @plant4
    @plot3.plants << @plant5

    visit garden_path(@garden1)
  end

  it 'shows all plants being grown in this garden with under 100 days to harvest' do 
    expect(page).to have_content(@plant2.name, count: 1)
    expect(page).to have_content(@plant3.name, count: 1)
    expect(page).to have_content(@plant4.name, count: 1)

    expect(page).to_not have_content(@plant1.name)
    expect(page).to_not have_content(@plant5.name)
  end
end