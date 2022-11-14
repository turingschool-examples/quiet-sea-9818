require 'rails_helper'

RSpec.describe "Plots Index Page" do
  before :each do
    @garden = Garden.create!(name: "Turing Community Garden", organic: true)
    @plot1 = Plot.create!(number: 25, size: "Large", direction: "East", garden: @garden)
    @plot2 = Plot.create!(number: 26, size: "Medium", direction: "West", garden: @garden)
    @plant1 = Plant.create!(name: "Plant1", description: "desc1", days_to_harvest: 60)
    @plant2 = Plant.create!(name: "Plant2", description: "desc2", days_to_harvest: 65)
    @plant3 = Plant.create!(name: "Plant3", description: "desc3", days_to_harvest: 75)
    @plant4 = Plant.create!(name: "Plant4", description: "desc4", days_to_harvest: 70)
    @pp1 = PlotPlant.create!(plot: @plot1, plant: @plant1)
    @pp2 = PlotPlant.create!(plot: @plot1, plant: @plant3)
    @pp3 = PlotPlant.create!(plot: @plot2, plant: @plant2)
    @pp4 = PlotPlant.create!(plot: @plot2, plant: @plant4)
  end


  describe "As a visitor" do
    describe "When I visit the plots index page ('/plots')" do
      it "I see a list of all plot numbers" do
        visit "/plots"

        expect(page).to have_content("Plots Index")

        within("#plot-#{@plot1.id}") do
          expect(page).to have_content("Plot Number: 25")
        end

        within("#plot-#{@plot2.id}") do
          expect(page).to have_content("Plot Number: 26")
        end
      end

      it "And under each plot number I see the names of all that plot's plants" do
        visit "/plots"
        # save_and_open_page

        within("#plot-#{@plot1.id}") do
          expect(page).to have_content("Plant Name: Plant1")
          expect(page).to have_content("Plant Name: Plant3")
        end

        within("#plot-#{@plot2.id}") do
          expect(page).to have_content("Plant Name: Plant2")
          expect(page).to have_content("Plant Name: Plant4")
        end
      end

      describe "Next to each plant's name" do
        it "I see a link to remove that plant from that plot" do
          visit "/plots"
          # save_and_open_page

          within("#plot-#{@plot1.id}") do
            expect(page).to have_button("Delete Plant1")
            expect(page).to have_button("Delete Plant3")
          end

          within("#plot-#{@plot2.id}") do
            expect(page).to have_button("Delete Plant2")
            expect(page).to have_button("Delete Plant4")
          end
        end

        describe "When I click on that link" do
          it "I'm returned to the plots index page, And I no longer see that plant listed under that plot, And I still see that plant's name under other plots that it was associated with." do
            pp5 = PlotPlant.create!(plot: @plot1, plant: @plant4)

            visit "/plots"
            # save_and_open_page

            within("#plot-#{@plot1.id}") do
              expect(page).to have_button("Delete Plant1")
              expect(page).to have_button("Delete Plant3")
              expect(page).to have_button("Delete Plant4")
              click_button("Delete Plant4")
            end

            expect(current_path).to eq("/plots")
            # save_and_open_page

            within("#plot-#{@plot1.id}") do
              expect(page).to have_content("Plant Name: Plant1")
              expect(page).to have_content("Plant Name: Plant3")
              expect(page).to_not have_content("Plant Name: Plant4")
            end

            within("#plot-#{@plot2.id}") do
              expect(page).to have_content("Plant Name: Plant2")
              expect(page).to have_content("Plant Name: Plant4")
            end
          end
        end
      end
    end
  end
end
