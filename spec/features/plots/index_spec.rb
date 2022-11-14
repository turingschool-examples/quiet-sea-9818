require 'rails_helper'

RSpec.describe 'Plots Index Page', type: :feature do
  let!(:garden_1) {Garden.create!(name: 'Oki Garden', organic: true)}

  let!(:plot_1) {garden_1.plots.create!(number: 25, size: 'Large', direction: 'West')}
  let!(:plot_2) {garden_1.plots.create!(number: 33, size: 'Large', direction: 'East')}
  let!(:plot_3) {garden_1.plots.create!(number: 5, size: 'Extra Small', direction: 'East')}

  let!(:daisy) {Plant.create!(name: 'Daisy', description: 'Prefers rich, well draining soil', days_to_harvest: 90)}
  let!(:rose) {Plant.create!(name: 'Rose', description: 'Prefers rich soil', days_to_harvest: 15)}
  let!(:lavender) {Plant.create!(name: 'Lavendar', description: 'smells delicious', days_to_harvest: 75)}

  describe 'plots#index' do
    it 'shows a list of all plot numbers' do
      visit plots_path

      within ("#plot-#{plot_1.id}") do
        expect(page).to have_content("##{plot_1.number}")
      end

      within ("#plot-#{plot_2.id}") do
        expect(page).to have_content("##{plot_2.number}")
      end

      within ("#plot-#{plot_3.id}") do
        expect(page).to have_content("##{plot_3.number}")
      end
    end

    it 'next to each plot number I see the names of all that plots plants' do
      PlantPlot.create!(plant: lavender, plot: plot_1)
      PlantPlot.create!(plant: rose, plot: plot_1)
      PlantPlot.create!(plant: daisy, plot: plot_2)

      visit plots_path
      
      within ("#plot-#{plot_1.id}") do
        expect(page).to have_content('My Plants:')
        expect(page).to have_content(lavender.name)
        expect(page).to have_content(rose.name)

        expect(page).to_not have_content(daisy.name)
      end
    end

    it 'next to each plant name I see a link to remove that plant from the plot' do
      PlantPlot.create!(plant: lavender, plot: plot_1)
      PlantPlot.create!(plant: rose, plot: plot_1)
      PlantPlot.create!(plant: daisy, plot: plot_2)

      visit plots_path

      within ("#plot-#{plot_1.id}") do
        expect(page).to have_link('Delete Plant')
      end
    end

    it 'after clicking the delete link, I am taken back to the index page where I no longer see that plant listed under that plot, but see it under other plots' do
      PlantPlot.create!(plant: lavender, plot: plot_1)
      PlantPlot.create!(plant: rose, plot: plot_1)
      PlantPlot.create!(plant: daisy, plot: plot_2)
      PlantPlot.create!(plant: lavender, plot: plot_2)

      visit plots_path

      within("#plot-#{plot_1.id}") do
        expect(page).to have_content(lavender.name)
      end
     
      within ("##{plot_1.id}-#{lavender.id}") do
        click_link 'Delete Plant'
      end

      expect(current_path).to eq(plots_path)

      within("#plot-#{plot_1.id}") do
        expect(page).to_not have_content(lavender.name)
      end

      within("#plot-#{plot_2.id}") do
        expect(page).to have_content(lavender.name)
      end
    end
  end
end