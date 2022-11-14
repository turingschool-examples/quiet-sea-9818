require 'rails_helper'

RSpec.describe 'plot index page' do
  before(:each) do
    @garden = Garden.create!(name: "Family Farm", organic: true)
    
    @plot_1 = @garden.plots.create!(number: 1, size: "medium", direction: "Sout West")
    @plot_2 = @garden.plots.create!(number: 2, size: "small", direction: "North")
    @plot_3 = @garden.plots.create!(number: 3, size: "large", direction: "North East")
    @plot_4 = @garden.plots.create!(number: 4, size: "medium", direction: "West")

    @plant_1 = Plant.create!(name: "Watermelon", description: "Juicy fruit", days_to_harvest: 30)
    @plant_2 = Plant.create!(name: "Cucumber", description: "Refreshing snack", days_to_harvest: 14)
    @plant_3 = Plant.create!(name: "Tomato", description: "Red and delicious", days_to_harvest: 18)
    @plant_4 = Plant.create!(name: "Corn", description: "Sweet vegetable", days_to_harvest: 60)
    @plant_5 = Plant.create!(name: "Strawberry", description: "Sweet snack", days_to_harvest: 105)
    @plant_6 = Plant.create!(name: "Pumpkin", description: "Great for Jack-o-lanters", days_to_harvest: 110)

    PlotPlant.create!(plot: @plot_1, plant: @plant_1)
    PlotPlant.create!(plot: @plot_1, plant: @plant_2)
    PlotPlant.create!(plot: @plot_1, plant: @plant_3)

    PlotPlant.create!(plot: @plot_2, plant: @plant_4)
    PlotPlant.create!(plot: @plot_2, plant: @plant_5)

    PlotPlant.create!(plot: @plot_3, plant: @plant_1)

    PlotPlant.create!(plot: @plot_4, plant: @plant_5)
    PlotPlant.create!(plot: @plot_4, plant: @plant_6)
  end

  it 'shows the plot numbers and plants in that plot' do
    visit plots_path

    within("#plot-#{@plot_1.id}") do
      expect(page).to have_content(@plant_1.name)
      expect(page).to have_content(@plant_2.name)
      expect(page).to have_content(@plant_3.name)
      expect(page).to_not have_content(@plant_4.name)
      expect(page).to_not have_content(@plant_5.name)
      expect(page).to_not have_content(@plant_6.name)
    end

    within("#plot-#{@plot_2.id}") do
      expect(page).to_not have_content(@plant_1.name)
      expect(page).to_not have_content(@plant_2.name)
      expect(page).to_not have_content(@plant_3.name)
      expect(page).to have_content(@plant_4.name)
      expect(page).to have_content(@plant_5.name)
      expect(page).to_not have_content(@plant_6.name)
    end

    within("#plot-#{@plot_3.id}") do
      expect(page).to have_content(@plant_1.name)
      expect(page).to_not have_content(@plant_2.name)
      expect(page).to_not have_content(@plant_3.name)
      expect(page).to_not have_content(@plant_4.name)
      expect(page).to_not have_content(@plant_5.name)
      expect(page).to_not have_content(@plant_6.name)
    end

    within("#plot-#{@plot_4.id}") do
      expect(page).to_not have_content(@plant_1.name)
      expect(page).to_not have_content(@plant_2.name)
      expect(page).to_not have_content(@plant_3.name)
      expect(page).to_not have_content(@plant_4.name)
      expect(page).to have_content(@plant_5.name)
      expect(page).to have_content(@plant_6.name)
    end
  end

  it 'has a link to remove a plant from a plot' do
    visit plots_path

    within("#plot-#{@plot_1.id}") do
      expect(page).to have_content(@plant_1.name)
      expect(page).to have_link("Remove #{@plant_1.name}")
      expect(page).to have_content(@plant_2.name)
      expect(page).to have_link("Remove #{@plant_2.name}")
      expect(page).to have_content(@plant_3.name)
      expect(page).to have_link("Remove #{@plant_3.name}")
    end

    within("#plot-#{@plot_2.id}") do
      expect(page).to have_content(@plant_4.name)
      expect(page).to have_link("Remove #{@plant_4.name}")
      expect(page).to have_content(@plant_5.name)
      expect(page).to have_link("Remove #{@plant_5.name}")
    end

    within("#plot-#{@plot_3.id}") do
      expect(page).to have_content(@plant_1.name)
      expect(page).to have_link("Remove #{@plant_1.name}")
    end

    within("#plot-#{@plot_4.id}") do
      expect(page).to have_content(@plant_5.name)
      expect(page).to have_link("Remove #{@plant_5.name}")
      expect(page).to have_content(@plant_6.name)
      expect(page).to have_link("Remove #{@plant_6.name}")
    end
  end

  it 'can remove a plant from a plot' do
    visit plots_path

    within("#plot-#{@plot_1.id}") do
      expect(page).to have_content(@plant_1.name)
      expect(page).to have_link("Remove #{@plant_1.name}")
      expect(page).to have_content(@plant_2.name)
      expect(page).to have_link("Remove #{@plant_2.name}")
      expect(page).to have_content(@plant_3.name)
      expect(page).to have_link("Remove #{@plant_3.name}")

      click_on "Remove #{@plant_3.name}"
    end

    expect(current_path).to eq(plots_path)

    within("#plot-#{@plot_1.id}") do
      expect(page).to have_content(@plant_1.name)
      expect(page).to have_link("Remove #{@plant_1.name}")
      expect(page).to have_content(@plant_2.name)
      expect(page).to have_link("Remove #{@plant_2.name}")
      expect(page).to_not have_content(@plant_3.name)
      expect(page).to_not have_link("Remove #{@plant_3.name}")
    end
  end
end