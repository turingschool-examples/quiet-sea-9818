require 'rails_helper'

RSpec.feature "Plots Index Page", type: :feature do
  before :each do
    @garden = Garden.create!(name: 'Salad Garden', organic: true)
    @plot_1 = @garden.plots.create!(number: 1, size: 'Large', direction: 'East')
    @plot_2 = @garden.plots.create!(number: 14, size: 'Small', direction: 'South')
    @plot_3 = @garden.plots.create!(number: 21, size: 'Medium', direction: 'West')

    @plant_1 = @plot_1.plants.create!(name: 'Cherry Tomato', description: 'Bears small, sweet tomatoes.', days_to_harvest: 90)
    @plant_2 = @plot_1.plants.create!(name: 'Green Bell Pepper', description: 'Medium sized bell peppers.', days_to_harvest: 120)
    @plant_3 = @plot_2.plants.create!(name: 'Cabbage', description: 'Leafy green.', days_to_harvest: 120)
    
    @plant_plot = PlantPlot.create!(plot_id: @plot_3.id, plant_id: @plant_1.id)
  end
  describe 'when visiting the page' do
    it 'lists all plot numbers' do
      visit plots_path

      expect(page).to have_content('1')
      expect(page).to have_content('14')
      expect(page).to have_content('21')
    end

    it 'lists all plants in a plot under the plot number' do
      visit plots_path

      within "#plot_#{@plot_1.id}" do
        expect(page).to have_content('Cherry Tomato')
        expect(page).to have_content('Green Bell Pepper')
        expect(page).not_to have_content('Cabbage')
      end
    end

    it 'has a link next to each plant that removes the plant from the plot it is under' do
      visit plots_path

      within "#plot_#{@plot_3.id}" do
        expect(page).to have_content('Cherry Tomato')
      end

      within "#plot_#{@plot_1.id}" do
        expect(page).to have_content('Cherry Tomato')
      end
      
      within "#plot_#{@plot_1.id}" do
        within "#plant_#{@plant_1.id}" do
          click_link 'Remove'
        end
        expect(page).not_to have_content('Cherry Tomato')
      end

      within "#plot_#{@plot_3.id}" do
        expect(page).to have_content('Cherry Tomato')
      end
    end
  end
end
