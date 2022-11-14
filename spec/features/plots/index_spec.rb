require "rails_helper"


RSpec.describe("Plots Index page") do
  before(:each) do
    @garden1 = Garden.create(    name: "Turing Community Garden",     organic: true)
    @plot1 = Plot.create!(    number: 25,     size: "Large",     direction: "East",     garden: @garden1)
    @plant1 = @plot1.plants.create!(    name: "Purple Beauty Sweet Bell Pepper",     description: "Prefers rich, well draining soil.",     days_to_harvest: 90)
    @plant2 = @plot1.plants.create!(    name: "Sunflower",     description: "well draining soil.",     days_to_harvest: 60)
    @plot2 = Plot.create!(    number: 20,     size: "Medium",     direction: "West",     garden: @garden1)
    @plant1 = @plot2.plants.create!(    name: "Purple Beauty Sweet Bell Pepper",     description: "Prefers rich, well draining soil.",     days_to_harvest: 90)
    @plant3 = @plot2.plants.create!(    name: "Rose",     description: "Prefers rich",     days_to_harvest: 100)
    @plot3 = Plot.create!(    number: 15,     size: "Small",     direction: "South",     garden: @garden1)
    @plant4 = @plot3.plants.create!(    name: "Lily",     description: "Prefers Sand",     days_to_harvest: 50)
  end

  describe("As a visitor") do
    describe("When I visit the plots index page ('/plots')") do
      describe("I see a list of all plot numbers") do
        it("And under each plot number I see the names of all that plot's plants") do
          visit(plots_path)

          within("#plot-#{@plot1.number}") do
            expect(page).to(have_content("Plot Number:#{@plot1.number}"))
            expect(page).to(have_content("Plot Plants:#{@plant1.name}"))
            expect(page).to(have_content("Plot Plants:#{@plant2.name}"))
          end

          within("#plot-#{@plot2.number}") do
            expect(page).to(have_content("Plot Number:#{@plot2.number}"))
            expect(page).to(have_content("Plot Plants:#{@plant3.name}"))
          end

          within("#plot-#{@plot3.number}") do
            expect(page).to(have_content("Plot Number:#{@plot3.number}"))
            expect(page).to(have_content("Plot Plants:#{@plant4.name}"))
          end
        end
      end
    end
  end

  describe("Next to each plant's name") do
    describe("I see a link to remove that plant from that plot") do
      it("When I click on that link I'm returned to the plots index page") do
        visit(plots_path)
        save_and_open_page

        within("#plot-#{@plot1.number}") do
          expect(page).to(have_content("Plot Number:#{@plot1.number}"))
          expect(page).to(have_content("Plot Plants:#{@plant1.name}"))
          expect(page).to(have_link("Remove #{@plant1.name} from Plot"))
          expect(page).to(have_content("Plot Plants:#{@plant2.name}"))
          expect(page).to(have_link("Remove #{@plant2.name} from Plot"))
        end
      end

      it("I no longer see that plant listed under that plot,") do
        visit(plots_path)
        save_and_open_page

        within("#plot-#{@plot1.number}") do
          expect(page).to(have_content("Plot Number:#{@plot1.number}"))
          expect(page).to(have_content("Plot Plants:#{@plant1.name}"))
          expect(page).to(have_link("Remove #{@plant1.name} from Plot"))
          click_link("Remove #{@plant1.name} from Plot")
          expect(current_path).to(eq(plots_path))
        end
      end

      it("And I still see that plant's name under other plots that it was associated with.") do
        visit(plots_path)

        within("#plot-#{@plot2.number}") do
          expect(page).to(have_content("Plot Number:#{@plot2.number}"))
          expect(page).to(have_content("Plot Plants:#{@plant1.name}"))
          expect(page).to(have_content("Plot Plants:#{@plant3.name}"))
          expect(page).to(have_link("Remove #{@plant1.name} from Plot"))
          click_link("Remove #{@plant1.name} from Plot")
          expect(current_path).to(eq(plots_path))
        end

          #save_and_open_page
        within("#plot-#{@plot1.number}") do
          expect(page).to(have_content("#{@plant1.name}"))
        end
      end
    end
  end
end
