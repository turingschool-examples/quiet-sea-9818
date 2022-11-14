require 'rails_helper'

RSpec.describe 'garden Show Page' do 
  before :each do 
    @garden1 = Garden.create!(name: "Private Garden", organic: false)
    @garden2 = Garden.create!(name: "Illegal Garden", organic: true)

    @plot1 = @garden2.plots.create!(number: 12, size: "Large", direction: "South")
    @plot2 = @garden2.plots.create!(number: 13, size: "small", direction: "North")
    @plot3 = @garden2.plots.create!(number: 14, size: "Medium", direction: "West")
    @plot4 = @garden1.plots.create!(number: 15, size: "Medium", direction: "East")

    @plant1 = Plant.create!(name: "Hallucenagenic Mushroom", description: "Make the world a bit funnier", days_to_harvest: 4555 )
    @plant2 = Plant.create!(name: "A Green FLower", description: "Smells like a skunk", days_to_harvest: 50 )
    @plant3 = Plant.create!(name: "Ayuhasca", description: "Find yourself beyond the vail", days_to_harvest: 80 )

    @plot_plant1 = PlotPlant.create!(plot_id: @plot4.id, plant_id: @plant3.id )
    @plot_plant2 = PlotPlant.create!(plot_id: @plot4.id, plant_id: @plant2.id )
    @plot_plant3 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant3.id) 
    @plot_plant4 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant1.id )

  end
  
  
  
  it 'I see a list of plants that are included in that gardens plots, Aand I see that this list is unique (no duplicates)
          and I see that this list only includes plants that take less than 100 days to Harvest' do 

          visit garden_path(@garden1)

      expect(page).to have_content(@garden1.name)
      expect(page).to_not have_content(@garden2.name)

      expect(page).to have_content([@plant3.name])
      expect(page).to have_content([@plant2.name])


  end
end 