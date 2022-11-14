require 'rails_helper'

RSpec.describe "Plot Index page ('/plots')" do
  before(:each) do
    @turing = Garden.create!(name: "Turing Community Garden", organic: true )
    @safeway = Garden.create!(name: "SafeWay Gardens", organic: false )
    @jersey = Garden.create!(name: "Garden State", organic: true )

    @rocky = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: @turing.id)
    @midwest = Plot.create!(number: 100, size: "Super Large", direction: "Midwest", garden_id: @safeway.id)
    @coast = Plot.create!(number: 75, size: "Super Large", direction: "East Coast", garden_id: @jersey.id)

    @purplebeauty = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    @tulips = Plant.create!(name: "Tulips", description: "Lots of sun, rich, well draining soil.", days_to_harvest: 40)
    @rose = Plant.create!(name: "Red Rose", description: "Prefers rich, well draining soil.", days_to_harvest: 50)
    @zooplant = Plant.create!(name: "Variety", description: "Dry.", days_to_harvest: 70)

    @combo1 = PlotPlant.create!(plot: @rocky, plant: @tulips)
    @combo2 = PlotPlant.create!(plot: @coast, plant: @rose )
    @combo3 = PlotPlant.create!(plot: @midwest, plant: @purplebeauty)
    @combo4 = PlotPlant.create!(plot: @rocky, plant: @purplebeauty )
    @combo5 = PlotPlant.create!(plot: @midwest, plant: @rose)
    @combo6 = PlotPlant.create!(plot: @rocky, plant: @zooplant )
    end
  
  
  describe "Page discplays a list of all plot numbers" do
    it "under each plot number I see the names of all that plot's plants" do
      visit ('/plots')

      expect(page).to have_content(@rocky.number)
      expect(page).to have_content(@midwest.number)
      
      # within("#plant-list-#{@coast.id}") do
        expect(page).to have_content(@coast.number)
        expect(page).to have_content(@rose.name)
        # expect(page).to_not have_content(@tulips.name)
      # end
    end
  end


  describe "Story 2-Index has Remove a Plant from a Plot" do
    describe "I see a link to remove that plant from that plot" do
      describe "when I click on that link I'm returned to the plots index page" do
        it "And I no longer see that plant listed under that plot, but other plants remain" do
          visit ('/plots')

          # expect(page).to have_content(@zooplant.name)
# save_and_open_page
          within("#plant-list-#{@zooplant.id}") do
            expect(page).to_not have_content(@tulips.name)
            expect(page).to have_content(@zooplant.name)
            expect(page).to have_content('Delete This Plant')
         end
    
         save_and_open_page
         within("#plant-list-#{@zooplant.id}") do
          click_link ('Delete This Plant')
        end
        
          expect(page).to_not have_content(@zooplant.name)         
          expect(current_path).to eq(plots_path)

        end
      end 
    end
  end
end