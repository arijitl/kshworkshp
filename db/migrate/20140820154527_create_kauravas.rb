class CreateKauravas < ActiveRecord::Migration
  def change
    create_table :kauravas do |t|
      t.integer :game_id
      t.string :name
      t.integer :points
      t.integer :pstart
      t.integer :pcurrent
      t.boolean :defeated

      t.timestamps
    end
  end
end
