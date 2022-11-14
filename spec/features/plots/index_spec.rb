require 'rails_helper'

RSpec.describe Plot do
# User Story 1, Plots Index Page
# As a visitor
# When I visit the plots index page ('/plots')
# I see a list of all plot numbers
# And under each plot number I see the names of all that plot's plants
  describe 'User Story 1 visit index page' do
    it 'shows the plot number & their plants' do
      garden_1 = Garden.create!(name: "Turing Community Garden", organic: true)
      garden_2 = Garden.create!(name: "Dublin's Garden", organic: true)
      
      plot_1 = garden_1.plots.create!(number: 20, size: "Medium", direction: "North", garden_id: garden_1.id)
      plot_2 = garden_1.plots.create!(number: 34, size: "Large", direction: "East", garden_id: garden_2.id)
     

      plant_1 = Plant.create!(name: "Pumpkin", description: "Jack 'O Lantern", days_to_harvest: 45)
      plant_2 = Plant.create!(name: "Squash", description: "a disguisting veggie", days_to_harvest: 23)
      plant_3 = Plant.create!(name: "Rose", description: "A rose by any other name", days_to_harvest: 56)

      plantplot_1 = PlantPlot.create(plant: plant_1, plot: plot_1)
      plantplot_1 = PlantPlot.create(plant: plant_2, plot: plot_1)
      plantplot_2 = PlantPlot.create(plant: plant_3, plot: plot_2)
     

      visit "/plots"
      expect(current_path).to eq("/plots")
      #save_and_open_page
     
      
        expect(page).to have_content(plant_1.name)
        expect(page).to have_content(plant_2.name)
       
      
     
    end
  end

# User Story 2, Remove a Plant from a Plot
# As a visitor
# When I visit the plots index page
# Next to each plant's name
# I see a link to remove that plant from that plot
# When I click on that link
# I'm returned to the plots index page
# And I no longer see that plant listed under that plot,
# And I still see that plant's name under other plots that it was associated with.
   describe 'creating a link to remove plant from plot without deleting it' do 
    it 'creates a link nect to each plants name to remove it from that plot' do 
      garden_1 = Garden.create!(name: "Turing Community Garden", organic: true)
      garden_2 = Garden.create!(name: "Dublin's Garden", organic: true)
      
      plot_1 = garden_1.plots.create!(number: 20, size: "Medium", direction: "North", garden_id: garden_1.id)
      plot_2 = garden_1.plots.create!(number: 34, size: "Large", direction: "East", garden_id: garden_2.id)
     

      plant_1 = Plant.create!(name: "Pumpkin", description: "Jack 'O Lantern", days_to_harvest: 45)
      plant_2 = Plant.create!(name: "Squash", description: "a disguisting veggie", days_to_harvest: 23)
      plant_3 = Plant.create!(name: "Rose", description: "A rose by any other name", days_to_harvest: 56)

      plantplot_1 = PlantPlot.create(plant: plant_1, plot: plot_1)
      plantplot_1 = PlantPlot.create(plant: plant_2, plot: plot_1)
      plantplot_2 = PlantPlot.create(plant: plant_3, plot: plot_2)
      
      visit "/plots"

       expect(page).to have_content(plant_1.name)
       expect(page).to have_link("Remove #{plant_1.name}")
       expect(page).to have_content(plant_2.name)
       expect(page).to have_link("Remove #{plant_2.name}")

       click_link("Remove #{plant_1.name}")

       expect(page).to_not have_content(plant_1.name)

     end
    end

end