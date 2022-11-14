require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) }
    it { should have_many(:plants).through(:plot_plants) }
  end
  
  before :each do
    @eden = Garden.create(name:"Eden", organic: true)
    @secret_garden = Garden.create(name:"The Secret Garden", organic: true)
    
    @plot1 = Plot.create(number: 1, size: "Large", direction: "East", garden_id: @eden.id)
    @plot2 = Plot.create(number: 2, size: "Large", direction: "West", garden_id: @eden.id)
    @secret_garden_plot = Plot.create(number: 2, size: "Large", direction: "West", garden_id: @secret_garden.id)
    @tomato = Plant.create(name: "Tomato", description: "Likes sun", days_to_harvest: 110)
    @zucchini = Plant.create(name: "Zucchini", description: "Only good in bread", days_to_harvest: 90)
    @squash = Plant.create(name: "Squash", description: "Does anyone even eat this?", days_to_harvest: 85)
    @potatoes = Plant.create(name: "Pumpkin", description: "Boil 'em, Mash 'em, stick 'em in a stew", days_to_harvest: 85)
    
    @plot1.plants << @tomato
    @plot1.plants << @zucchini
    @plot1.plants << @squash
    @plot2.plants << @squash
    @plot2.plants << @tomato
    @secret_garden_plot.plants << @squash
  end
  
  describe 'instance methods' do
    describe '#unique_plants_under_100' do
      it "returns a list of unique plants where the days_to_harvest is less
      than 100" do
        expect(@eden.unique_plants_under_100).to eq([@squash, @zucchini])
      end
    end
  end
end
