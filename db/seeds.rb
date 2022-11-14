# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@garden = Garden.create!(name: "Cole Neighborhood Garden", organic: false)
@plot_1 = @garden.plots.create!(number: 1, size: "Large", direction: "East")
@plot_2 = @garden.plots.create!(number: 2, size: "Medium", direction: "West")
@hibiscus = Plant.create!(name: "Hibiscus", description: "Tropical Flower", days_to_harvest: 50)
@corn = Plant.create!(name: "Corn", description: "Your basic corn", days_to_harvest: 95)
@sage = Plant.create!(name: "Desert Sage", description: "The common and delicios desert sage", days_to_harvest: 36)
@hops = Plant.create!(name: "Vine Hops", description: "Fast growing hops vine", days_to_harvest: 12)

PlantPlot.create!(plant: @hibiscus, plot: @plot_1)
PlantPlot.create!(plant: @corn, plot: @plot_1)
PlantPlot.create!(plant: @sage, plot: @plot_1)
PlantPlot.create!(plant: @hops, plot: @plot_2)
PlantPlot.create!(plant: @hibiscus, plot: @plot_2)