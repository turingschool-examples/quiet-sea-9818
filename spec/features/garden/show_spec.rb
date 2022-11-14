require "rails_helper"

RSpec.describe("Garden Show Page") do
  before(:each) do
    @garden_1 = Garden.create(name: "Garden1", organic: true)
    @plot_1 = @garden_1.plots.create(number: 1, size: 'small', direction: 'north')
    @plant_1 = @plot_1.plants.create(name: 'plant1', description: 'a plant', days_to_harvest: 100)
    @plant_2 = @plot_1.plants.create(name: 'plant2', description: 'also here', days_to_harvest: 1)

    @plot_2 = @garden_1.plots.create(number: 2, size: 'small(ish)', direction: 'north north west')
    @plot_2.plants << @plant_2
    @plant_3 = @plot_2.plants.create(name: 'plant3', description: 'also here', days_to_harvest: 1)

    @garden_2 = Garden.create(name: "Garden2", organic: false)
    @plot_3 = @garden_2.plots.create(number: 3, size: 'large', direction: 'south')
    @plant_4 = @plot_3.plants.create(name: 'plant4', description: 'not here', days_to_harvest: 7)

    visit garden_path(@garden_1)
  end
  describe 'When I visit /gardens/:id' do
    describe 'Then I see' do
      it 'a distinct list of plants, in that gardens plots, with < 100 days to harvest' do
        within "#garden-plant-list" do
          expect(page).to have_content(@plant_2.name, count: 1)
          expect(page).to have_content(@plant_3.name, count: 1)

          expect(page).to_not have_content(@plant_1.name)
          expect(page).to_not have_content(@plant_4.name)
        end
      end

      it 'the list is sorted by total times that plant is found in the garden (regardless of plot)' do
        4.times { @plot_2.plants << @plant_4 }
        visit garden_path(@garden_1)

        expect(@plant_4.name).to appear_before(@plant_2.name)
        expect(@plant_2.name).to appear_before(@plant_3.name)
      end
    end
  end
end