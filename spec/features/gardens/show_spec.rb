require 'rails_helper'

RSpec.describe 'garden index page' do
  before(:each) do
    @garden_1 = Garden.create!(name: "Family Farm", organic: true)
    @garden_2 = Garden.create!(name: "Fran's Farm", organic: false)
    
    @plot_1 = @garden_1.plots.create!(number: 1, size: "medium", direction: "Sout West")
    @plot_2 = @garden_1.plots.create!(number: 2, size: "small", direction: "North")
    @plot_3 = @garden_1.plots.create!(number: 3, size: "large", direction: "North East")
    @plot_4 = @garden_1.plots.create!(number: 4, size: "medium", direction: "West")
    @plot_5 = @garden_2.plots.create!(number: 45, size: "Extra large", direction: "South")

    @plant_1 = Plant.create!(name: "Watermelon", description: "Juicy fruit", days_to_harvest: 30)
    @plant_2 = Plant.create!(name: "Cucumber", description: "Refreshing snack", days_to_harvest: 14)
    @plant_3 = Plant.create!(name: "Tomato", description: "Red and delicious", days_to_harvest: 18)
    @plant_4 = Plant.create!(name: "Corn", description: "Sweet vegetable", days_to_harvest: 60)
    @plant_5 = Plant.create!(name: "Strawberry", description: "Sweet snack", days_to_harvest: 105)
    @plant_6 = Plant.create!(name: "Pumpkin", description: "Great for Jack-o-lanters", days_to_harvest: 110)

    PlotPlant.create!(plot: @plot_1, plant: @plant_1)
    PlotPlant.create!(plot: @plot_1, plant: @plant_2)
    PlotPlant.create!(plot: @plot_1, plant: @plant_3)

    PlotPlant.create!(plot: @plot_2, plant: @plant_3)
    PlotPlant.create!(plot: @plot_2, plant: @plant_4)
    PlotPlant.create!(plot: @plot_2, plant: @plant_5)

    PlotPlant.create!(plot: @plot_3, plant: @plant_1)
    PlotPlant.create!(plot: @plot_3, plant: @plant_3)

    PlotPlant.create!(plot: @plot_4, plant: @plant_5)
    PlotPlant.create!(plot: @plot_4, plant: @plant_6)
    
    PlotPlant.create!(plot: @plot_5, plant: @plant_1)
    PlotPlant.create!(plot: @plot_5, plant: @plant_2)
  end

  it 'lists all plants that are included in that gardens plots' do
    visit garden_path(@garden_1)

    expect(page).to have_content(@plant_1.name, count: 1)
    expect(page).to have_content(@plant_2.name, count: 1)
    expect(page).to have_content(@plant_3.name, count: 1)
    expect(page).to have_content(@plant_4.name, count: 1)
  end

  # it 'sorts the plants in order of most appearance in plots to least' do
  #   visit garden_path(@garden_1)

  #   expect(@plant_3.name).to appear_before(@plant_1.name)
  #   expect(@plant_1.name).to appear_before(@plant_2.name)
  #   expect(@plant_2.name).to appear_before(@plant_4.name)
  # end
end
