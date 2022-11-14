require 'rails_helper'

RSpec.describe 'the plots index' do 
  before(:each) do 
    @garden1 = Garden.create!(name: 'Elitch Gardens', organic: false)

    @plot1 = @garden1.plots.create!(number: 25, size: 'Large', direction: 'East')
    @plot2 = @garden1.plots.create!(number: 10, size: 'Small', direction: 'West')

    @plant1 = Plant.create!(name: 'Doom Pepper', description: 'Spicy as hell', days_to_harvest: 140)
    @plant2 = Plant.create!(name: 'Happy Carrots', description: 'They so cute', days_to_harvest: 80)
    @plant3 = Plant.create!(name: 'Corn', description: 'A big lump with knobs', days_to_harvest: 90)
    @plant4 = Plant.create!(name: 'Rainbow Tomatoes', description: 'Theyre magically delicious', days_to_harvest: 20)

    @plot1.plants << @plant1 << @plant2
    @plot2.plants << @plant1 << @plant3 << @plant4

    visit plots_path
  end

  it 'shows all plot numbers and a list of their plants' do 
    within "#plot-#{@plot1.id}" do 
      expect(page).to have_content(@plot1.number)
      expect(page).to have_content(@plant1.name)
      expect(page).to have_content(@plant2.name)
      expect(page).to_not have_content(@plant3.name)
    end

    within "#plot-#{@plot2.id}" do 
      expect(page).to have_content(@plot2.number)
      expect(page).to have_content(@plant1.name)
      expect(page).to have_content(@plant3.name)
      expect(page).to have_content(@plant4.name)
      expect(page).to_not have_content(@plant2.name)
    end
  end

  it 'has buttons to remove each plant' do 
    within "#plot-#{@plot1.id}" do 
      expect(page).to have_content(@plant1.name)
      within "#plant-#{@plant1.id}" do 
        click_button "Delete"
      end
    end

    expect(current_path).to eq(plots_path)
    
    within "#plot-#{@plot1.id}" do 
      expect(page).to_not have_content(@plant1.name)
    end
    within "#plot-#{@plot2.id}" do 
      expect(page).to have_content(@plant1.name)
    end
  end
end
