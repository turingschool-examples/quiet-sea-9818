require 'rails_helper'

RSpec.describe 'the plots index page' do
  before :each do
    @garden1 = Garden.create!(name: 'Twinleaf Garden', organic: true)
    @garden2 = Garden.create!(name: 'Jubilife Garden', organic: false)
    @plot1 = @garden1.plots.create!(number: 1, size: 'Large', direction: 'East')
    @plot2 = @garden1.plots.create!(number: 2, size: 'Medium', direction: 'North')
    @plot3 = @garden1.plots.create!(number: 3, size: 'Small', direction: 'South')
    @plot4 = @garden2.plots.create!(number: 28, size: 'Large', direction: 'West')
    @plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich soil.", days_to_harvest: 90)
    @plant2 = Plant.create!(name: "Red Chili Pepper", description: "Very red.", days_to_harvest: 80)
    @plant3 = Plant.create!(name: "Napa Cabbage", description: "Requires loosened soil.", days_to_harvest: 70)
    @plant4 = Plant.create!(name: "Nuclear", description: "Radioactive, produces energy.", days_to_harvest: 600)
    @plant5 = Plant.create!(name: "Cactus", description: "Spiky.", days_to_harvest: 90)
    @plant6 = Plant.create!(name: "Test", description: "Test.", days_to_harvest: 900)

    PlotPlant.create!(plot: @plot1, plant: @plant1)
    PlotPlant.create!(plot: @plot2, plant: @plant2)
    PlotPlant.create!(plot: @plot3, plant: @plant3)
    PlotPlant.create!(plot: @plot4, plant: @plant4)
    PlotPlant.create!(plot: @plot3, plant: @plant5)
  end
  it "lists all plot numbers and the names of each plot's plants" do
    visit plots_path
    # save_and_open_page
    within "#plot#{@plot1.id}" do
      expect(page).to have_content("Plot ##{@plot1.number}")
      expect(page).to have_content(@plant1.name)
      expect(page).to_not have_content("Plot ##{@plot3.number}")
      expect(page).to_not have_content(@plant3.name)
    end
    within "#plot#{@plot2.id}" do
      expect(page).to have_content("Plot ##{@plot2.number}")
      expect(page).to have_content(@plant2.name)
    end
    within "#plot#{@plot3.id}" do
      expect(page).to have_content("Plot ##{@plot3.number}")
      expect(page).to have_content(@plant3.name)
      expect(page).to have_content(@plant5.name)
    end
    within "#plot#{@plot4.id}" do
      expect(page).to have_content("Plot ##{@plot4.number}")
      expect(page).to have_content(@plant4.name)
    end
    expect(page).to_not have_content(@plant6.name)
  end
  it "has a link next to each plant to remove that plant from the plot" do
    visit plots_path

    within "#plot#{@plot1.id}" do
      expect(page).to have_link("Remove #{@plant1.name}")
      click_link "Remove #{@plant1.name}"
      # save_and_open_page
      expect(page).to_not have_content(@plant1.name)
    end
    within "#plot#{@plot2.id}" do
      expect(page).to have_link("Remove #{@plant2.name}")
    end
    within "#plot#{@plot3.id}" do
      expect(page).to have_link("Remove #{@plant3.name}")
      expect(page).to have_link("Remove #{@plant5.name}")
      click_link "Remove #{@plant3.name}"
      # save_and_open_page
      expect(page).to_not have_content(@plant3.name)
      expect(page).to have_content(@plant5.name)
    end
    within "#plot#{@plot4.id}" do
      expect(page).to have_link("Remove #{@plant4.name}")
    end
  end
end
