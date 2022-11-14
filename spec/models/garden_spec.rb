require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  describe 'methods' do
    before :each do
      @garden_1 = Garden.create!(name: "Botanical Gardens", organic: true)
      @plot_1 = @garden_1.plots.create!(number: 1, size: "Large", direction: "East")
      @plot_2 = @garden_1.plots.create!(number: 2, size: "Medium", direction: "North")
      @plot_3 = @garden_1.plots.create!(number: 3, size: "Medium", direction: "West")
      @plot_4 = @garden_1.plots.create!(number: 4, size: "Medium", direction: "West")
      @plot_5 = @garden_1.plots.create!(number: 5, size: "Medium", direction: "West")
      @plant_1 = Plant.create!(name: "Lily", description: "Ummm?", days_to_harvest: 99)
      @plot_1.plants << @plant_1
      @plot_3.plants << @plant_1
      @plant_2 = Plant.create!(name: "Lotus", description: "Floatato?", days_to_harvest: 100)
      @plot_1.plants << @plant_2
      @plant_3 = Plant.create!(name: "Daisy", description: "Ermmm?", days_to_harvest: 90)
      @plot_1.plants << @plant_3 
      @plant_4 = Plant.create!(name: "Dahlia", description: "With an h!", days_to_harvest: 80)
      @plot_2.plants << @plant_4
      @plant_5 = Plant.create!(name: "Apricot", description: "Yum!", days_to_harvest: 70)
      @plot_2.plants << @plant_5
      @plant_6 = Plant.create!(name: "Birch", description: "I see in a lot of video games?", days_to_harvest: 86)
      @plot_3.plants << @plant_6
      @plant_7 = Plant.create!(name: "Rose", description: "Red?", days_to_harvest: 110)
      @plot_3.plants << @plant_7
      @plot_2.plants << @plant_1
      @plot_4.plants << @plant_1
      @plot_5.plants << @plant_1
      @plot_2.plants << @plant_3
      @plot_3.plants << @plant_3
      @plot_1.plants << @plant_4
      @plot_3.plants << @plant_4
      @plot_4.plants << @plant_4
      @plot_4.plants << @plant_5
    end

    describe '#plants_under_100_days' do
      # it 'returns an array of distinct plant records whose days to harvest are under 100' do
      #   expect(@garden_1.plants_under_100_days).to include(@plant_1, @plant_3, @plant_4, @plant_5, @plant_6)
      #   expect(@garden_1.plants_under_100_days.length).to eq(5)
      # end

      it "sorts the list of plants based on their count" do
        expect(@garden_1.plants_under_100_days).to eq({"Lily"=>5, "Dahlia"=>4, "Daisy"=>3, "Apricot"=>2, "Birch"=>1})
      end
    end
  end
end
