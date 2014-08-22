class AddVictoryToPandavas < ActiveRecord::Migration
  def change
    add_column :pandavas, :victory, :boolean
  end
end
