class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.integer :first_winner
      t.integer :second_winner
      t.integer :loser
      t.boolean :drawn_game
      t.boolean :first_leader_waiting
      t.boolean :second_leader_waiting
      t.boolean :third_leader_waiting
      t.boolean :fourth_leader_waiting
      t.integer :first_winner_hand
      t.integer :second_winner_hand

      t.timestamps
    end
  end
end
