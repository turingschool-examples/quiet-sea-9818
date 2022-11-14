require 'rails_helper'

RSpec.describe 'plots index page', type: :feature do
  describe 'as a visitor' do
    describe 'when I visit plots_path' do
      before(:each) do
        @my_garden = Garden.create!(name: "Kenz's Garden", organic: true)

        @plot_1 = Plot.create!(number: 1, size: "Small", direction: "West", garden_id: @my_garden.id)
        @plot_2 = Plot.create!(number: 2, size: "Medium", direction: "Southwest", garden_id: @my_garden.id)
        @plot_3 = Plot.create!(number: 3, size: "Large", direction: "North", garden_id: @my_garden.id)

        @strawberries = Plant.create!(name: "Summer Strawberries", description: "So Juicy & Delicious!", days_to_harvest: 180)
        @kale = Plant.create!(name: "Dino Kale", description: "Hardy & Versitile!", days_to_harvest: 60)
        @plums = Plant.create!(name: "Plum Tree", description: "Worth The Wait!", days_to_harvest: 250)
        @bananas = Plant.create!(name: "San Juan Banana Tree", description: "We don't know how they grow here either!", days_to_harvest: 45)
        @bell_peppers = Plant.create!(name: "Green Bell Peppers", description: "A Classic!", days_to_harvest: 100)

        @plot_1.plants << @strawberries
        @plot_1.plants << @plums
        @plot_2.plants << @kale
        @plot_2.plants << @strawberries
        @plot_2.plants << @bell_peppers
        @plot_3.plants << @bananas
        @plot_3.plants << @strawberries

        visit plots_path
      end

      it '- shows a list of all plot numbers, and under each plot lists all of that plots plants' do
        expect(page).to have_css("#plot-#{@plot_1.id}")
        expect(page).to have_css("#plot-#{@plot_2.id}")
        expect(page).to have_css("#plot-#{@plot_3.id}")

        within "#plot-#{@plot_1.id}" do
          expect(page).to have_content("Plants in Plot #1:")
          expect(page).to have_content("Summer Strawberries")
          expect(page).to have_content("Plum Tree")
          expect(page).to_not have_content("Green Bell Peppers")
        end

        within "#plot-#{@plot_2.id}" do
          expect(page).to have_content("Plants in Plot #2:")
          expect(page).to have_content("Dino Kale")
          expect(page).to have_content("Summer Strawberries")
          expect(page).to have_content("Green Bell Peppers")
          expect(page).to_not have_content("San Juan Banana Tree")
        end

        within "#plot-#{@plot_3.id}" do
          expect(page).to have_content("Plants in Plot #3:")
          expect(page).to have_content("San Juan Banana Tree")
          expect(page).to have_content("Summer Strawberries")
          expect(page).to_not have_content("Green Bell Peppers")
        end
      end

      it '- has a link next to each plant name to remove that plant from the plot' do
        expect(page).to have_css("#plants-#{@plot_1.id}")  
        expect(page).to have_css("#plants-#{@plot_2.id}")  
        expect(page).to have_css("#plants-#{@plot_3.id}")  

        within "#plants-#{@plot_1.id}" do
          expect(page).to have_link("Remove Summer Strawberries")
          expect(page).to have_link("Remove Plum Tree")
          expect(page).to_not have_link("Remove Green Bell Peppers")
        end

        within "#plants-#{@plot_2.id}" do
          expect(page).to have_link("Remove Dino Kale")
          expect(page).to have_link("Remove Summer Strawberries")
          expect(page).to have_link("Remove Green Bell Peppers")
          expect(page).to_not have_content("Remove San Juan Banana Tree")
        end

        within "#plants-#{@plot_3.id}" do
          expect(page).to have_link("Remove San Juan Banana Tree")
          expect(page).to have_link("Remove Summer Strawberries")
          expect(page).to_not have_link("Remove Green Bell Peppers")
        end
      end

      xit '- when I click on that link, I am redirected back to the plots index and I no longer see
      that plant listed under that plot, and I still see that plants name under other plots' do
        within "#plants-#{@plot_1.id}" do
          click_link "Remove Summer Strawberries"
        end

        expect(current_path).to eq(plots_path)

        within "#plot-#{@plot_1.id}" do
          expect(page).to have_content("Plants in Plot #1:")
          expect(page).to have_content("Plum Tree")
          expect(page).to_not have_content("Summer Strawberries")
        end

        within "#plot-#{@plot_2.id}" do
          expect(page).to have_content("Plants in Plot #2:")
          expect(page).to have_content("Dino Kale")
          expect(page).to have_content("Summer Strawberries")
          expect(page).to have_content("Green Bell Peppers")
        end

        within "#plot-#{@plot_3.id}" do
          expect(page).to have_content("Plants in Plot #3:")
          expect(page).to have_content("San Juan Banana Tree")
          expect(page).to have_content("Summer Strawberries")
        end
      end
    end
  end
end