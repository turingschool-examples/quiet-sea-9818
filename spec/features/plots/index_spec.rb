require 'rails_helper'

RSpec.describe 'Plots' do
  before(:each) do
    @garden1 = Garden.create!(name: 'Turing Community Garden', organic: true)

    @plot1 = @garden1.plots.create!(number: 25, size: 'Large', direction: 'East')
    @plot2 = @garden1.plots.create!(number: 26, size: 'Medium', direction: 'West')

    @shared_plant = Plant.create!(name: 'shared plant', description: 'its dope', days_to_harvest: 5)

    @plant1 = @plot1.plants.create!(name: 'Red Beauty Sweet Bell Pepper',
                                    description: 'Prefers rich, well draining soil.', days_to_harvest: 90)
    @plant2 = @plot1.plants.create!(name: 'Orange pumpkins', description: 'Prefers dry soil.', days_to_harvest: 200)
    @plant3 = @plot1.plants.create!(name: 'Yellow Corn', description: 'soil.', days_to_harvest: 20)

    @plant4 = @plot2.plants.create!(name: 'Green Beans', description: 'Fertilizer', days_to_harvest: 600)
    @plant5 = @plot2.plants.create!(name: 'Blue Corn', description: 'Prefers sand', days_to_harvest: 60)
    @plant6 = @plot2.plants.create!(name: 'Indigo Bell Pepper', description: 'Prefers rocks', days_to_harvest: 490)

    @plot1.plants << @shared_plant
    @plot2.plants << @shared_plant
  end

  describe '/plots' do
    it 'lists the plot numbers' do
      visit '/plots'
      expect(page).to have_content(25)
      expect(page).to have_content(26)
      expect(page).to have_content('Red Beauty Sweet Bell Pepper')
      expect(page).to have_content('Orange pumpkins')
      expect(page).to have_content('Yellow Corn')
      expect(page).to have_content('Green Beans')
      expect(page).to have_content('Blue Corn')
      expect(page).to have_content('Indigo Bell Pepper')
    end

    it 'has a link to remove the individual plants' do
      visit '/plots'
      expect(page).to have_link("remove #{@plant1.name}")
      expect(page).to have_link("remove #{@plant2.name}")
      expect(page).to have_link("remove #{@plant3.name}")
      expect(page).to have_link("remove #{@plant4.name}")
      expect(page).to have_link("remove #{@plant5.name}")
      expect(page).to have_link("remove #{@plant6.name}")
      expect(page).to have_link("remove #{@shared_plant.name}", count: 2)
      first(:link, "remove #{@shared_plant.name}").click
      expect(current_path).to eq("/plots")
      expect(page).to have_link("remove #{@shared_plant.name}", count: 1)
    end
  end

  describe 'gardens/:garden_id/plots' do
    it 'lists the plot numbers' do
      visit "/gardens/#{@garden1.id}/plots"
      expect(page).to have_content(25)
      expect(page).to have_content(26)
      expect(page).to have_content('Red Beauty Sweet Bell Pepper')
      expect(page).to have_content('Orange pumpkins')
      expect(page).to have_content('Yellow Corn')
      expect(page).to have_content('Green Beans')
      expect(page).to have_content('Blue Corn')
      expect(page).to have_content('Indigo Bell Pepper')
    end

    it 'has a link to remove the individual plants' do
      visit "/gardens/#{@garden1.id}/plots"
      expect(page).to have_link("remove #{@plant1.name}")
      expect(page).to have_link("remove #{@plant2.name}")
      expect(page).to have_link("remove #{@plant3.name}")
      expect(page).to have_link("remove #{@plant4.name}")
      expect(page).to have_link("remove #{@plant5.name}")
      expect(page).to have_link("remove #{@plant6.name}")
      expect(page).to have_link("remove #{@shared_plant.name}", count: 2)
      first(:link, "remove #{@shared_plant.name}").click
      expect(current_path).to eq("/plots")
      expect(page).to have_link("remove #{@shared_plant.name}", count: 1)
    end


  end
end
