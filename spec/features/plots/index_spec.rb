require 'rails_helper' do 

  describe 'plot index page' do 
    before :each do 
      @garden1 = Garden.create!(name: "Private Garden", organic: false)
      @garden2 = Garden.create!(name: "Illegal Garden", organic: true)

      @plot1 = @garden2.plots.create!(number: 12, size: "Large", direction: "South")
      @plot2 = @garden2.plots.create!(number: 13, size: "small", direction: "North")
      @plot3 = @garden2.plots.create!(number: 14, size: "Medium", direction: "West")
      @plot3 = @garden1.plots.create!(number: 15, size: "Medium", direction: "East")

      @plant1 = Plant.create!(name: "Hallucenagenic Mushroom", description: "Make the world a bit funnier", days_to_harvest: )

      PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot1.id)

    end
  end
end