require 'rails_helper'

RSpec.describe 'Plot Index' do
  before :each do
    @eden = Garden.create(name:"Eden", organic: true)
    @plot1 = Plot.create(number: 1, size: "Large", direction: "East", garden_id: @eden.id)
    @plot2 = Plot.create(number: 2, size: "Large", direction: "West", garden_id: @eden.id)
    @tomato = Plant.create(name: "Tomato", description: "Likes sun", days_to_harvest: 110)
    @zucchini = Plant.create(name: "Zucchini", description: "Only good in bread", days_to_harvest: 90)
    @squash = Plant.create(name: "Squash", description: "Does anyone even eat this?", days_to_harvest: 85)
    
    @plot1.plants << @tomato
    @plot1.plants << @zucchini
    @plot2.plants << @squash
    @plot2.plants << @tomato
    
    visit '/plots'
  end
  
  describe 'As a visitor' do
    it "I see a list of all plot numbers And under each plot number I see the
    names of all that plot's plants" do
      
      within("#plot-#{@plot1.number}") do
        expect(page).to have_content(@plot1.number)
        expect(page).to have_content(@tomato.name)
        expect(page).to have_content(@zucchini.name)
      end
      within("#plot-#{@plot2.number}") do
        expect(page).to have_content(@plot2.number)
        expect(page).to have_content(@squash.name)
        expect(page).to_not have_content(@zucchini.name)
      end
    end
    
    it "I see a link to remove that plant from that plot When I click on that
    link I'm returned to the plots index page And I no longer see that plant
    listed under that plot, And I still see that plant's name under other plots
    that it was associated with." do
    # save_and_open_page
      within("#plot-#{@plot1.number}") do
        expect(page).to have_link("Delete #{@tomato.name}")
        click_link "Delete #{@tomato.name}"
      end
      
      expect(current_path).to eq('/plots')
      
      within("#plot-#{@plot1.number}") do
        expect(page).to_not have_content(@tomato.name)
      end
    end
  end
end