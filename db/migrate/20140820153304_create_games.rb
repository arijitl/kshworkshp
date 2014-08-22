class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :client_id
      t.string :name
      t.integer :team_count
      t.integer :round_count

      t.timestamps
    end
  end
end
