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

        visit plots_path
      end

      it '- shows a list of all plot numbers, and under each plot lists all of that plots plants' do

      end
    end
  end
end