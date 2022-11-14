require 'rails_helper'  

  describe 'plot index page' do 
    before :each do 
      @garden1 = Garden.create!(name: "Private Garden", organic: false)
      @garden2 = Garden.create!(name: "Illegal Garden", organic: true)

      @plot1 = @garden2.plots.create!(number: 12, size: "Large", direction: "South")
      @plot2 = @garden2.plots.create!(number: 13, size: "small", direction: "North")
      @plot3 = @garden2.plots.create!(number: 14, size: "Medium", direction: "West")
      @plot4 = @garden1.plots.create!(number: 15, size: "Medium", direction: "East")

      @plant1 = Plant.create!(name: "Hallucenagenic Mushroom", description: "Make the world a bit funnier", days_to_harvest: 45 )
      @plant2 = Plant.create!(name: "A Green FLower", description: "Smells like a skunk", days_to_harvest: 50 )
      @plant3 = Plant.create!(name: "Ayuhasca", description: "Find yourself beyond the vail", days_to_harvest: 80 )

      PlotPlant.create!(plant_id: @plant1.id, plot_id: @plot1.id)
      PlotPlant.create!(plant_id: @plant2.id, plot_id: @plot1.id)
      PlotPlant.create!(plant_id: @plant3.id, plot_id: @plot2.id)

    end

    describe 'Plot information and content' do 
      it 'on plot index pagem I see a list of all plot numbers' do 
        visit plots_path

        expect(page).to have_content(@plot1.number)
        expect(page).to have_content(@plot2.number)
        expect(page).to have_content(@plot3.number)
        expect(page).to have_content(@plot4.number)
      end

      it 'Under each plot number I see the names of all the plots plants' do 

        visit plots_path

        within "#plot-#{@plot1.number}" do 
        expect(page).to have_content(@plant1.name)
        expect(page).to have_content(@plant2.name)
        expect(page).to_not have_content(@plant3.name)
        end 
      end
    end
  end
