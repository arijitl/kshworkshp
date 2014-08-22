class CreatePandavas < ActiveRecord::Migration
  def change
    create_table :pandavas do |t|
      t.integer :team_id
      t.string :name
      t.integer :attack
      t.boolean :used
      t.integer :kaurava_id

      t.timestamps
    end
  end
end
