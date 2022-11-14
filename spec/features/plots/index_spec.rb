require 'rails_helper'

RSpec.feature "Plots Index Page", type: :feature do
  before :each do
    @plot_1 = Plot.create!(number: 1, size: 'Large', direction: 'East')
    @plot_2 = Plot.create!(number: 14, size: 'Small', direction: 'South')
    @plot_3 = Plot.create!(number: 21, size: 'Medium', direction: 'West')

    @plant_1 = @plot_1.plants.create!(name: 'Cherry Tomato', description: 'Bears small, sweet tomatoes.', days_to_harvest: 90)
    @plant_2 = @plot_1.plants.create!(name: 'Green Bell Pepper', description: 'Medium sized bell peppers.', days_to_harvest: 120)
    @plant_3 = @plot_2.plants.create!(name: 'Cabbage', description: 'Leafy green.', days_to_harvest: 120)
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
  end
end
