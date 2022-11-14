# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  @garden1 = Garden.create!(name: "Private Garden", organic: false)
    @garden2 = Garden.create!(name: "Illegal Garden", organic: true)

    @plot1 = @garden2.plots.create!(number: 12, size: "Large", direction: "South")
    @plot2 = @garden2.plots.create!(number: 13, size: "small", direction: "North")
    @plot3 = @garden2.plots.create!(number: 14, size: "Medium", direction: "West")
    @plot4 = @garden1.plots.create!(number: 15, size: "Medium", direction: "East")

    @plant1 = Plant.create!(name: "Hallucenagenic Mushroom", description: "Make the world a bit funnier", days_to_harvest: 45 )
    @plant2 = Plant.create!(name: "A Green FLower", description: "Smells like a skunk", days_to_harvest: 50 )
    @plant3 = Plant.create!(name: "Ayuhasca", description: "Find yourself beyond the vail", days_to_harvest: 80 )

    @plot_plant1 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant1.id )
    @plot_plant2 = PlotPlant.create!(plot_id: @plot1.id, plant_id: @plant2.id )
    @plot_plant3 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant3.id) 
    @plot_plant4 = PlotPlant.create!(plot_id: @plot2.id, plant_id: @plant1.id )