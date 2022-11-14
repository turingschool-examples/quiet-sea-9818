require 'rails_helper'

RSpec.describe 'Garden Show Page', type: :feature do
  let!(:garden_1) {Garden.create!(name: 'Oki Garden', organic: true)}
  let!(:garden_2) {Garden.create!(name: 'Nomi Garden', organic: false)}

  let!(:plot_1) {garden_1.plots.create!(number: 25, size: 'Large', direction: 'West')}
  let!(:plot_2) {garden_1.plots.create!(number: 33, size: 'Large', direction: 'East')}
  let!(:plot_3) {garden_1.plots.create!(number: 5, size: 'Extra Small', direction: 'East')}
  let!(:plot_4) {garden_2.plots.create!(number: 10, size: 'Small', direction: 'South')}
  let!(:plot_5) {garden_1.plots.create!(number: 20, size: 'Medium', direction: 'South')}

  let!(:daisy) {Plant.create!(name: 'Daisy', description: 'Prefers rich, well draining soil', days_to_harvest: 90)}
  let!(:rose) {Plant.create!(name: 'Rose', description: 'Prefers rich soil', days_to_harvest: 15)}
  let!(:lavender) {Plant.create!(name: 'Lavendar', description: 'smells delicious', days_to_harvest: 75)}
  let!(:lily) {Plant.create!(name: 'Lily', description: 'i am pretty', days_to_harvest: 30)}
  let!(:venus) {Plant.create!(name: 'Venus Flytrap', description: 'eats your bugs', days_to_harvest: 150)}

  describe 'garden#show' do
    it 'I see a unique list of all plants that are included in the gardens plots' do
      PlantPlot.create!(plant: lavender, plot: plot_1)
      PlantPlot.create!(plant: rose, plot: plot_2)
      PlantPlot.create!(plant: rose, plot: plot_3)
      PlantPlot.create!(plant: daisy, plot: plot_3)
      PlantPlot.create!(plant: lily, plot: plot_4)

      visit garden_path(garden_1)

      expect(page).to have_content("#{garden_1.name}")
      expect(page).to_not have_content("#{garden_2.name}")

      within("#my-plants") do
        expect(page).to have_content(daisy.name, count: 1)
        expect(page).to have_content(rose.name, count: 1)
        expect(page).to have_content(lavender.name, count: 1)
        expect(page).to_not have_content(lily.name)
      end
    end

    it 'only shows plants that take less than 100 days to harvest' do
      PlantPlot.create!(plant: lavender, plot: plot_1)
      PlantPlot.create!(plant: rose, plot: plot_2)
      PlantPlot.create!(plant: rose, plot: plot_3)
      PlantPlot.create!(plant: daisy, plot: plot_3)
      PlantPlot.create!(plant: venus, plot: plot_3)

      visit garden_path(garden_1)

      within("#my-plants") do
        expect(page).to have_content(daisy.name, count: 1)
        expect(page).to have_content(rose.name, count: 1)
        expect(page).to have_content(lavender.name, count: 1)
        expect(page).to_not have_content(venus.name)
      end
    end

    it 'shows the list of plants sorted by number of plants appearing in any of the gardens plots from most to least' do
      PlantPlot.create!(plant: daisy, plot: plot_3)
      PlantPlot.create!(plant: daisy, plot: plot_1)
      PlantPlot.create!(plant: daisy, plot: plot_2)

      PlantPlot.create!(plant: lavender, plot: plot_1)
      PlantPlot.create!(plant: lavender, plot: plot_2)
      PlantPlot.create!(plant: lavender, plot: plot_3)
      PlantPlot.create!(plant: lavender, plot: plot_5)

      PlantPlot.create!(plant: rose, plot: plot_2)
      PlantPlot.create!(plant: rose, plot: plot_3)

      PlantPlot.create!(plant: lily, plot: plot_3)

      visit garden_path(garden_1)
      
      within("#my-plants") do
        expect("#{lavender.name}").to appear_before("#{daisy.name}")
        expect("#{daisy.name}").to appear_before("#{rose.name}")
        expect("#{rose.name}").to appear_before("#{lily.name}")
      end
    end
  end
end