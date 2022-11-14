require 'rails_helper'

RSpec.describe 'plot index page' do
  let!(:garden1) { Garden.create!(name: 'Bat World', organic: true) }
  let!(:garden2) { Garden.create!(name: 'Krytpon', organic: false) }

  let!(:plant1) { Plant.create!(name: 'Batplant', description: 'Tastes like chicken', days_to_harvest: 50) }
  let!(:plant2) { Plant.create!(name: 'Kryptonian Tomato', description: 'Tastes like radiation', days_to_harvest: 80) }
  let!(:plant3) { Plant.create!(name: 'Banana', description: 'Probably a vegetable', days_to_harvest: 15) }
  let!(:plant4) { Plant.create!(name: 'Yarrow Flower', description: 'For Migo', days_to_harvest: 180) }
  let!(:plant5) { Plant.create!(name: 'Blueberries', description: 'Also a vegetable', days_to_harvest: 99) }

  let!(:plot1) { garden1.plots.create!(number: 4, size: 'Medium', direction: 'West') }
  let!(:plot2) { garden1.plots.create!(number: 15, size: 'Small', direction: 'West') }
  let!(:plot3) { garden1.plots.create!(number: 24, size: 'Medium', direction: 'South') }
  let!(:plot4) { garden1.plots.create!(number: 1, size: 'Large', direction: 'East') }
  let!(:plot5) { garden1.plots.create!(number: 45, size: 'Small', direction: 'North') }
  let!(:plot6) { garden2.plots.create!(number: 71, size: 'Medium', direction: 'West') }
  let!(:plot7) { garden2.plots.create!(number: 100, size: 'Large', direction: 'North') }

  let!(:plant_plot1) { PlantPlot.create!(plant_id: plant1.id, plot_id: plot1.id) }
  let!(:plant_plot2) { PlantPlot.create!(plant_id: plant1.id, plot_id: plot2.id) }
  let!(:plant_plot3) { PlantPlot.create!(plant_id: plant2.id, plot_id: plot1.id) }
  let!(:plant_plot4) { PlantPlot.create!(plant_id: plant3.id, plot_id: plot7.id) }
  let!(:plant_plot5) { PlantPlot.create!(plant_id: plant4.id, plot_id: plot5.id) }
  let!(:plant_plot6) { PlantPlot.create!(plant_id: plant5.id, plot_id: plot4.id) }

  before :each do
    visit plots_path
  end

  describe 'when I visit the plot index page' do
    it 'has a list of all plot numbers and names of each plots plants' do
      expect(current_path).to eq(plots_path)

      within '#plots' do
        expect(page).to have_content("Plot number - #{plot1.number}")
        expect(page).to have_content("Plot number - #{plot2.number}")
        expect(page).to have_content("Plot number - #{plot3.number}")
        expect(page).to have_content("Plot number - #{plot4.number}")
        expect(page).to have_content("Plot number - #{plot5.number}")
        expect(page).to have_content("Plot number - #{plot6.number}")
        expect(page).to have_content("Plot number - #{plot7.number}")
      end

      within "#plot-#{plot1.id}" do
        expect(page).to have_content(plant1.name)
        expect(page).to have_content(plant2.name)
        expect(page).to_not have_content(plant3.name)
        expect(page).to_not have_content(plant4.name)
      end

      within "#plot-#{plot2.id}" do
        expect(page).to have_content(plant1.name)
        expect(page).to_not have_content(plant2.name)
        expect(page).to_not have_content(plant3.name)
        expect(page).to_not have_content(plant4.name)
      end
    end

    it 'has a link next to each plants name to remove plant from that plot' do
      within "#plot-#{plot1.id}" do
        expect(page).to have_link("Remove #{plant1.name}")
        expect(page).to have_link("Remove #{plant2.name}")
      end
      within "#plot-#{plot2.id}" do
        expect(page).to have_link("Remove #{plant1.name}")
      end
    end

    it 'can click on the link to remove plant from that plot only' do
      within "#plot-#{plot1.id}" do
        click_link("Remove #{plant1.name}")
      end

      expect(current_path).to eq(plots_path)

      within "#plot-#{plot1.id}" do
        expect(page).to_not have_content(plant1.name)
        expect(page).to have_content(plant2.name)
        expect(page).to_not have_content(plant3.name)
        expect(page).to_not have_content(plant4.name)
      end
    end
  end
end
