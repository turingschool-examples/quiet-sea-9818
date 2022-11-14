# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PlantPlot.destroy_all
Plant.destroy_all
Plot.destroy_all
Garden.destroy_all

@garden1 = Garden.create!(name: 'Turing Community Garden', organic: true)

@plot1 = @garden1.plots.create!(number: 25, size: 'Large', direction: 'East')
@plot2 = @garden1.plots.create!(number: 26, size: 'Medium', direction: 'West')

@shared_plant = Plant.create!(name: 'shared plant', description: 'its dope', days_to_harvest: 5)

@plant1 = @plot1.plants.create!(name: 'Red Beauty Sweet Bell Pepper',
                                description: 'Prefers rich, well draining soil.', days_to_harvest: 90)
@plant2 = @plot1.plants.create!(name: 'Orange pumpkins', description: 'Prefers dry soil.', days_to_harvest: 200)
@plant3 = @plot1.plants.create!(name: 'Yellow Corn', description: 'soil.', days_to_harvest: 20)

@plant4 = @plot2.plants.create!(name: 'Green Beans', description: 'Fertilizer', days_to_harvest: 600)
@plant5 = @plot2.plants.create!(name: 'Blue Corn', description: 'Prefers sand', days_to_harvest: 60)
@plant6 = @plot2.plants.create!(name: 'Indigo Bell Pepper', description: 'Prefers rocks', days_to_harvest: 490)

@plot1.plants << @shared_plant
@plot2.plants << @shared_plant

