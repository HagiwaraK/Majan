class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :honba
      t.string :round
      t.integer :first_leader_score
      t.integer :second_leader_score
      t.integer :third_leader_score
      t.integer :fourth_leader_score

      t.timestamps
    end
  end
end
