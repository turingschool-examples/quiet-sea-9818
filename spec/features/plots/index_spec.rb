require "rails_helper"

RSpec.describe "the Plots Index page" do 
  before(:each) do 
    @garden = Garden.create!(name: "Cole Neighborhood Garden", organic: false)
    @plot_1 = @garden.plots.create!(number: 1, size: "Large", direction: "East")
    @plot_2 = @garden.plots.create!(number: 2, size: "Medium", direction: "West")
    @hibiscus = Plant.create!(name: "Hibiscus", description: "Tropical Flower", days_to_harvest: 50)
    @corn = Plant.create!(name: "Corn", description: "Your basic corn", days_to_harvest: 95)
    @sage = Plant.create!(name: "Desert Sage", description: "The common and delicios desert sage", days_to_harvest: 36)
    @hops = Plant.create!(name: "Vine Hops", description: "Fast growing hops vine", days_to_harvest: 12)

    PlantPlot.create!(plant: @hibiscus, plot: @plot_1)
    PlantPlot.create!(plant: @corn, plot: @plot_1)
    PlantPlot.create!(plant: @sage, plot: @plot_1)
    PlantPlot.create!(plant: @hops, plot: @plot_2)
    PlantPlot.create!(plant: @hibiscus, plot: @plot_2)

    other_garden = Garden.create!(name: "Whittier Garden", organic: true)
    plot_3 = other_garden.plots.create!(number: 3, size: "Small", direction: "North")
  end

  describe "As a visitor when I visit /plots" do 
    it "displays a list of all the plot numbers, and all that plots' plants" do 
      visit garden_plots_path(@garden)

      within "#plot-#{@plot_1.id}" do 
        expect(page).to have_content("Plot Number: 1")
        expect(page).to have_content("Hibiscus")
        expect(page).to have_content("Corn")
        expect(page).to have_content("Desert Sage")
      end

      within "#plot-#{@plot_2.id}" do 
        expect(page).to have_content("Plot Number: 2")
        expect(page).to have_content("Vine Hops")
        expect(page).to have_content("Hibiscus")
      end

      expect(page).to_not have_content("Plot Number: 3")
    end

    it "has a link to remove each plant, when clicked i'm redirected to the index page and the plant has been deleted from that plot only" do 
      visit garden_plots_path(@garden)

      within "#plot-#{@plot_1.id}" do 
        within "#plant-#{@hibiscus.id}" do 
          expect(page).to have_button("Remove Plant")
        end
        within "#plant-#{@corn.id}" do 
          expect(page).to have_button("Remove Plant")
        end
        within "#plant-#{@sage.id}" do 
          expect(page).to have_button("Remove Plant")
        end
      end

      within "#plot-#{@plot_2.id}" do 
        within "#plant-#{@hops.id}" do 
          expect(page).to have_button("Remove Plant")
        end
        within "#plant-#{@hibiscus.id}" do 
          expect(page).to have_button("Remove Plant")

          click_button("Remove Plant")
        end
      end

      expect(current_path).to eq(garden_plots_path(@garden))

      within "#plot-#{@plot_1.id}" do 
        expect(page).to have_content("Hibiscus") 
      end

      within "#plot-#{@plot_2.id}" do 
        expect(page).to_not have_content("Hibiscus") 
      end
    end
  end
end