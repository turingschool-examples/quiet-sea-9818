require 'rails_helper'

RSpec.describe 'Plot Index' do
  before :each do
    @garden1 = Garden.create!(name: 'Backyard Garden', organic: true)

    @plot1 = Plot.create!(number: 1, size: 'small', direction: 'north', garden_id: @garden1.id)
    @plot2 = Plot.create!(number: 2, size: 'medium', direction: 'east', garden_id: @garden1.id)
    @plot3 = Plot.create!(number: 3, size: 'large', direction: 'south', garden_id: @garden1.id)

    @plant1 = Plant.create!(name: 'potato', description: 'grows in the ground', days_to_harvest: 30)
    @plant2 = Plant.create!(name: 'green bean', description: 'grows on a bush', days_to_harvest: 30)
    @plant3 = Plant.create!(name: 'orange', description: 'grows on a tree', days_to_harvest: 30)

    @pp1 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant1.id)
    PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant2.id)
    PlotPlant.create!(plot_id: @plot3.id, plant_id: @plant3.id)

  end
  describe 'index' do
    it "I see a list of all plot numbers and under each plot number I see the names of all that plot's plants" do
      visit "/plots"

      expect(page).to have_content("Plot Number: 1")
      expect(page).to have_content("Plot Number: 2")
      expect(page).to have_content("Plot Number: 3")
      expect(page).to have_content('Plant Name: potato')
      expect(page).to have_content('Plant Name: green bean')
      expect(page).to have_content('Plot Number: 3')

    end
  end
  describe 'destroy' do
    it "Next to each plant's name
    I see a link to remove that plant from that plot
    When I click on that link
    I'm returned to the plots index page
    And I no longer see that plant listed under that plot,
    And I still see that plant's name under other plots that it was associated with." do
    
    @pp4 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant1.id)
    
    visit "/plots"


    click_on "Delete potato #{@pp1.id}"

    save_and_open_page
    expect(page).to_not have_content("Delete potato #{@pp1.id}")
    expect(page).to have_content("Delete potato #{@pp4.id}")

    end
  end
end
