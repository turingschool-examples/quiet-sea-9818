class CreatePlotPlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plot_plants do |t|
      t.bigint :plot_id
      t.bigint :plant_id
    end
  end
end
