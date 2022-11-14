class DropPlantPlots < ActiveRecord::Migration[5.2]
  def change
    drop_table :plant_plots
  end
end
