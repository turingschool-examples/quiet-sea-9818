# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@garden_1 = Garden.create!(name: "Turing Community Garden", organic: true)
@plot_1 = @garden_1.plots.create!(number: 25, size: "Large", direction: "East")
@plot_2 = @garden_1.plots.create!(number: 26, size: "Medium", direction: "North")
@plot_3 = @garden_1.plots.create!(number: 27, size: "Small", direction: "West")
@plant_1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefer Rich", days_to_harvest: 90)
@plant_2 = Plant.create!(name: "Red Beauty", description: "Prefer Poor", days_to_harvest: 30)
@plant_3 = Plant.create!(name: "Blue Beauty", description: "Prefer Average", days_to_harvest: 45)
@plot_plant_1 = PlotPlant.create(plot: @plot_1, plant: @plant_1)
@plot_plant_2 = PlotPlant.create(plot: @plot_2, plant: @plant_2)
@plot_plant_3 = PlotPlant.create(plot: @plot_3, plant: @plant_3)
@plot_plant_4 = PlotPlant.create(plot: @plot_3, plant: @plant_3)
@plot_plant_5 = PlotPlant.create(plot: @plot_3, plant: @plant_2)
@plot_plant_6 = PlotPlant.create(plot: @plot_3, plant: @plant_1)
