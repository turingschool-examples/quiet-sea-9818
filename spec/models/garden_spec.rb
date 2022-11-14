require 'rails_helper'

RSpec.describe Garden do
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

  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plant_plots).through(:plots) }
    it { should have_many(:plants).through(:plant_plots) }
  end

  describe 'instance methods' do
    it 'returns the list of my plants ordered by amount of times present in my plots from greatest to least' do
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

      expect(garden_1.ordered_plants).to eq([lavender, daisy, rose, lily])
    end
  end
end
