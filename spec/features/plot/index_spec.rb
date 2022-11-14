require 'rails_helper'

RSpec.describe "Plot Index Page", type: :feature do

  before(:each) do
    @garden_1 = Garden.create!(name: "Blonde Dog Farm", organic: true)
    @garden_2 = Garden.create!(name: "Leah's Flowers", organic: true)
    @garden_3 = Garden.create!(name: "Foley Farm", organic: false)

    @plot_1 = @garden_1.plots.create!(number: 4, size: "small", direction: "east")
    @plot_2 = @garden_1.plots.create!(number: 56 , size: "x-large", direction: "west")
    @plot_3 = @garden_1.plots.create!(number: 20, size: "medium", direction: "north")
    @plot_4 = @garden_2.plots.create!(number: 35, size: "large", direction: "east")
    @plot_5 = @garden_3.plots.create!(number: 75, size: "x-large", direction: "south")
    @plot_6 = @garden_1.plots.create!(number: 10, size: "large", direction: "south")
    
    @plant_1 = Plant.create!(name: "Hanners Best Apple Tree", description: "very large apples", days_to_harvest: 145)
    @plant_2 = Plant.create!(name: "Armenian Cucumber", description: "weet and spineless", days_to_harvest: 75)
    @plant_3 = Plant.create!(name: "Unknown Variety Raspberries", description: "prolific, excellent flavor, does not keep", days_to_harvest: 83)
    @plant_4 = Plant.create!(name: "Varigated Sage", description: "great for cooking", days_to_harvest: 67)
    @plant_5 = Plant.create!(name: "Plout", description: "Dapple Dandy", days_to_harvest: 102)
    @plant_6 = Plant.create!(name: "Nikita's Gift Persimmon", description: "non astringent", days_to_harvest: 180)
    @plant_7 = Plant.create!(name: "Orcas Pear", description: "buttery and juicy", days_to_harvest: 145)
    @plant_8 = Plant.create!(name: "Cocheco Asian Plum", description: "beautiful, purple foliage", days_to_harvest: 145)
    @plant_9 = Plant.create!(name: "Contorted Flowering Quince", description: "stuning pink and white blossoms", days_to_harvest: 145)
    @plant_10 = Plant.create!(name: "Pucia Super Mol Medlar", description: "large fruit set", days_to_harvest: 145)

    @plot_plant_1 = PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_1.id)
    @plot_plant_2 = PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_2.id)
    @plot_plant_3 = PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_3.id)
    @plot_plant_4 = PlotPlant.create!(plot_id: @plot_2.id, plant_id: @plant_3.id)
    @plot_plant_5 = PlotPlant.create!(plot_id: @plot_2.id, plant_id: @plant_5.id)
    @plot_plant_6 = PlotPlant.create!(plot_id: @plot_3.id, plant_id: @plant_4.id)
  end

  it "shows a list of all of plot numbers and under each plot number there is a list of all of that plot's plants" do
    visit plots_path

    within("#plot-#{@plot_1.id}") do
      expect(page).to have_content(@plot_1.number)
      expect(page).to have_content(@plant_1.name)
      expect(page).to have_content(@plant_2.name)
      expect(page).to have_content(@plant_3.name)
    end

    within("#plot-#{@plot_2.id}") do
      expect(page).to have_content(@plot_2.number)
      expect(page).to have_content(@plant_3.name)
      expect(page).to have_content(@plant_5.name)
    end

    within("#plot-#{@plot_3.id}") do
      expect(page).to have_content(@plot_3.number)
      expect(page).to have_content(@plant_4.name)
    end

    within("#plot-#{@plot_4.id}") do
      expect(page).to have_content(@plot_4.number)
    end

    within("#plot-#{@plot_5.id}") do
      expect(page).to have_content(@plot_5.number)
    end

    within("#plot-#{@plot_6.id}") do
      expect(page).to have_content(@plot_6.number)
      expect(page).to have_no_content(@plant_4.name)
      expect(page).to have_no_content(@plant_1.name)
    end
  end

  it "has a link next to each plan's name to remove the plant from that plot" do
    visit plots_path

    within("#plot-#{@plot_1.id}") do
      expect(page).to have_link "Remove #{@plant_1.name}"
      expect(page).to have_link "Remove #{@plant_2.name}"
      expect(page).to have_link "Remove #{@plant_3.name}"
    end
  end

  it "when the link is clicked, the user is returned to the plots index page and
    the plant is no longer listed under that plot, however it is still listed under
    other plots that are associated with it" do
     visit plots_path

      within("#plot-#{@plot_1.id}") do
        expect(page).to have_content(@plant_3.name)
      end

      within("#plot-#{@plot_2.id}") do
        expect(page).to have_content(@plant_3.name)
        click_link "Remove #{@plant_3.name}"
      end

      expect(current_path).to eq(plots_path)

      within("#plot-#{@plot_1.id}") do
        expect(page).to have_content(@plant_3.name)
      end

      within("#plot-#{@plot_2.id}") do
        expect(page).to have_no_content(@plant_3.name)
      end
    end
end 