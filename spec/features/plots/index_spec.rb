require 'rails_helper'

RSpec.describe 'the plots index page' do
  before :each do
    @turing = Garden.create!(name: "Turing Community Garden", organic: true)
    @agritopia = Garden.create!(name: "Agritopia Farm", organic: true)
    @plot1 = @turing.plots.create!(number: 25, size: "Large", direction: "East")
    @plot2 = @turing.plots.create!(number: 87, size: "Small", direction: "West")
    @plot3 = @agritopia.plots.create!(number: 9, size: "Very Large", direction: "North")
    @plot4 = @agritopia.plots.create!(number: 35, size: "Medium", direction: "West")
    @pepper = Plant.create!(name: "Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    @potato = Plant.create!(name: "Yukon Gold", description: "Needs colder temps", days_to_harvest: 120)
    @squash = Plant.create!(name: "Yellow Squash", description: "Minimal care required", days_to_harvest: 60)
    @kale = Plant.create!(name: "Dino Kale", description: "Alkaline soil needed", days_to_harvest: 50)
    @tomato = Plant.create!(name: "Beefeater Tomato", description: "Enjoys full sun", days_to_harvest: 75)
    @plotplant1 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @potato.id)
    @plotplant2 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @kale.id)
    @plotplant3 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @pepper.id)
    @plotplant4 = PlotPlant.create!(plot_id: @plot3.id, plant_id: @squash.id)
    @plotplant5 = PlotPlant.create!(plot_id: @plot3.id, plant_id: @kale.id)
    @plotplant6 = PlotPlant.create!(plot_id: @plot4.id, plant_id: @pepper.id)
    @plotplant7 = PlotPlant.create!(plot_id: @plot4.id, plant_id: @tomato.id)
    visit plots_path
  end
  
  it 'lists all of the plot numbers' do
    expect(page).to have_content(@plot1.number)
    expect(page).to have_content(@plot2.number)
    expect(page).to have_content(@plot3.number)
    expect(page).to have_content(@plot4.number)
  end

  it 'displays all plants names associated with each plot' do
    within "#plot_plants_#{@plot1.id}" do
      expect(page).to have_content(@potato.name)
      expect(page).to have_content(@kale.name)
      expect(page).to_not have_content(@pepper.name)
    end

    within "#plot_plants_#{@plot2.id}" do
      expect(page).to have_content(@pepper.name)
      expect(page).to_not have_content(@potato.name)
      expect(page).to_not have_content(@kale.name)
    end

    within "#plot_plants_#{@plot3.id}" do
      expect(page).to have_content(@squash.name)
      expect(page).to have_content(@kale.name)
      expect(page).to_not have_content(@pepper.name)
      expect(page).to_not have_content(@tomato.name)
    end

    within "#plot_plants_#{@plot4.id}" do
      expect(page).to have_content(@pepper.name)
      expect(page).to have_content(@tomato.name)
      expect(page).to_not have_content(@squash.name)
      expect(page).to_not have_content(@kale.name)
    end
  end

  it 'has a link next to each plant name to remove plant from plot' do
    within "#plot_plants_#{@plot1.id}" do
      expect(page).to have_link("Remove")
    end
    
    within "#plot_plants_#{@plot2.id}" do
      expect(page).to have_link("Remove")
    end

    within "#plot_plants_#{@plot3.id}" do
      expect(page).to have_link("Remove")
    end

    within "#plot_plants_#{@plot4.id}" do
      expect(page).to have_link("Remove")
    end
  end

  it 'can remove a plot plant and still see the same plant associated with other plots' do
    within "#plot_plants_#{@plot2.id}" do
      first(:link, 'Remove').click_link('Remove')
    end

    expect(current_path).to eq(plots_path)
    
    within "#plot_plants_#{@plot2.id}" do
      expect(page).to_not have_content(@pepper.name)
    end
    within "#plot_plants_#{@plot4.id}" do
      expect(page).to have_content(@pepper.name)
    end
  end
end