require "rails_helper"

RSpec.describe("Plots Index Page") do
  before(:each) do
    garden_1 = Garden.create(name: "Garden1", organic: true)
    @plot_1 = garden_1.plots.create(number: 1, size: 'small', direction: 'north')
    @plant_1 = @plot_1.plants.create(name: 'plant1', description: 'a plant', days_to_harvest: 99)
    @plant_2 = @plot_1.plants.create(name: 'plant2', description: 'also here', days_to_harvest: 1)
    @plot_2 = garden_1.plots.create(number: 2, size: 'small(ish)', direction: 'north north west')

    garden_2 = Garden.create(name: "Garden2", organic: false)
    @plot_3 = garden_2.plots.create(number: 3, size: 'large', direction: 'south')
    @plant_3 = @plot_3.plants.create(name: 'plant3', description: 'not here', days_to_harvest: 70)

    visit plots_path(garden_1)
  end
  describe 'When I visit /plots' do
    describe 'Then I see' do
      it 'a list of all plot numbers' do
        within "#plot-list" do
          expect(page).to have_content(@plot_1.number)
          expect(page).to have_content(@plot_2.number)
          expect(page).to have_content(@plot_3.number)
        end
      end

      it 'under each plot number, name of each of that plots plants' do
        within "#plot-number-#{@plot_1.id}" do
          save_and_open_page
          expect(page).to have_content(@plant_1.name)
          expect(page).to have_content(@plant_2.name)

          expect(page).to_not have_content(@plant_3.name)
        end
        within "#plot-number-#{@plot_3.id}" do
          expect(page).to have_content(@plant_3.name)

          expect(page).to_not have_content(@plant_1.name)
          expect(page).to_not have_content(@plant_2.name)
        end
      end
    end
  end
end