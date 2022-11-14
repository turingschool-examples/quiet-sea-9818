require 'rails_helper'

RSpec.describe 'plot index page' do
  before :each do
    @garden1 = Garden.create!(name: "fun garden", organic: true)
    
    @plot1 = Plot.create!(number: 1, size: "10ft", direction: "north", garden_id: @garden1.id)
    @plot2 = Plot.create!(number: 2, size: "20ft", direction: "south", garden_id: @garden1.id)
    @plot3 = Plot.create!(number: 3, size: "30ft", direction: "east", garden_id: @garden1.id)
    
    @plant1 = Plant.create!(name: "daisy", description: "flower", days_to_harvest: 3)
    @plant2 = Plant.create!(name: "green beans", description: "edible", days_to_harvest: 33)
    @plant3 = Plant.create!(name: "potatoe", description: "edible", days_to_harvest: 11)

    @plot_plants1 = PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot1.id)
    @plot_plants2 = PlotPlant.create!(plant_id: @plant2.id, plot_id: @plot2.id)
    @plot_plants3 = PlotPlant.create!(plant_id: @plant3.id, plot_id: @plot2.id)
  end

  describe "As a visitor" do
    describe "when I visit plots index page" do
      it "I see a list of all plot numbers" do
        visit plots_path

        expect(page).to have_content(@plot1.number)
        expect(page).to have_content(@plot2.number)
        expect(page).to have_content(@plot3.number)
        expect(page).to_not have_content(@garden1.name)
        expect(page).to have_content(@plant1.name)
        expect(page).to have_content(@plant2.name)
        expect(page).to have_content(@plant3.name)

      end

      it 'has a link to delete a plant from a plot' do
        visit plots_path

        expect(page).to have_link("Remove #{@plant1.name}")
        expect(page).to have_link("Remove #{@plant2.name}")
        expect(page).to have_link("Remove #{@plant3.name}")
      end

      it "the link takes me to plots index page" do
        visit plots_path

        click_on("Remove #{@plant1.name}")
    
        expect(page).to have_current_path(plots_path)
        expect(page).to_not have_content("#{@plant1.name}")
      end
    end
  end
end
