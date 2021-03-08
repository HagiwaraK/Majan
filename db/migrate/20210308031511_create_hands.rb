class CreateHands < ActiveRecord::Migration[6.1]
  def change
    create_table :hands do |t|
      t.boolean :reach
      t.integer :value_tiles
      t.boolean :all_simples
      t.boolean :all_runs
      t.boolean :self_draw
      t.boolean :first_turn_win
      t.boolean :double_run
      t.boolean :haitei
      t.boolean :houtei
      t.boolean :kings_tile_draw
      t.boolean :double_reach
      t.boolean :add_a_quad
      t.integer :dora
      t.integer :red_dora
      t.integer :ura_dora
      t.boolean :all_triples
      t.boolean :three_color_runs
      t.boolean :seven_pairs
      t.boolean :full_straight
      t.boolean :mixed_outside_hand
      t.boolean :three_concealed_triples
      t.boolean :little_dragons
      t.boolean :all_terminals_and_honors
      t.boolean :three_color_triples
      t.boolean :three_quads
      t.boolean :hand_flush
      t.boolean :pure_outside_hand
      t.boolean :two_double_runs
      t.boolean :full_flush
      t.boolean :four_concealed_triples
      t.boolean :thirteen_orphans
      t.boolean :big_dragons
      t.boolean :four_winds
      t.boolean :all_honors
      t.boolean :all_terminals
      t.boolean :blessing_of_earth
      t.boolean :all_green
      t.boolean :nine_gates
      t.boolean :four_quads
      t.string :blessing_of_heaven
      t.boolean :open
      t.integer :han
      t.integer :hu

      t.timestamps
    end
  end
end
