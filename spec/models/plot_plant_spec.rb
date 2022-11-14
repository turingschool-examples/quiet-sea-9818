require 'rails_helper'

RSpec.describe PlotPlant do
  describe 'relationships' do
    it { should belong_to(:plot) }
    it { should belong_to(:plant) }
  end
  describe 'class methods' do
    describe '#find_plot_plant' do
      it 'Can find a PlotPlant using plant id and plot id' do
        garden1 = Garden.create!(name: 'Twinleaf Garden', organic: true)
        garden2 = Garden.create!(name: 'Jubilife Garden', organic: false)
        plot1 = garden1.plots.create!(number: 1, size: 'Large', direction: 'East')
        plot2 = garden1.plots.create!(number: 2, size: 'Medium', direction: 'North')
        plot3 = garden1.plots.create!(number: 3, size: 'Small', direction: 'South')
        plot4 = garden2.plots.create!(number: 28, size: 'Large', direction: 'West')
        plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich soil.", days_to_harvest: 90)
        plant2 = Plant.create!(name: "Red Chili Pepper", description: "Very red.", days_to_harvest: 80)
        plant3 = Plant.create!(name: "Napa Cabbage", description: "Requires loosened soil.", days_to_harvest: 70)
        plant4 = Plant.create!(name: "Nuclear", description: "Radioactive, produces energy.", days_to_harvest: 600)
        plant5 = Plant.create!(name: "Cactus", description: "Spiky.", days_to_harvest: 90)

        plot_plant1 = PlotPlant.create!(plot: plot1, plant: plant1)
        plot_plant2 = PlotPlant.create!(plot: plot2, plant: plant2)
        PlotPlant.create!(plot: plot3, plant: plant3)
        PlotPlant.create!(plot: plot4, plant: plant4)
        PlotPlant.create!(plot: plot3, plant: plant5)

        expect(PlotPlant.find_plot_plant(plot1.id, plant1.id)[0]).to eq(plot_plant1)
        expect(PlotPlant.find_plot_plant(plot2.id, plant2.id)[0]).to eq(plot_plant2)
      end
    end
  end
end
