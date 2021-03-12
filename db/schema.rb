# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_12_045659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer "honba"
    t.string "round"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "half_round_id"
    t.integer "kyoku"
    t.integer "kyotaku"
  end

  create_table "half_rounds", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "first_leader_user_id"
    t.integer "second_leader_user_id"
    t.integer "third_leader_user_id"
    t.integer "fourth_leader_user_id"
  end

  create_table "hands", force: :cascade do |t|
    t.boolean "reach"
    t.integer "value_tiles"
    t.boolean "all_simples"
    t.boolean "all_runs"
    t.boolean "self_draw"
    t.boolean "first_turn_win"
    t.boolean "double_run"
    t.boolean "haitei"
    t.boolean "houtei"
    t.boolean "kings_tile_draw"
    t.boolean "double_reach"
    t.boolean "add_a_quad"
    t.integer "dora"
    t.integer "red_dora"
    t.integer "ura_dora"
    t.boolean "all_triples"
    t.boolean "three_color_runs"
    t.boolean "seven_pairs"
    t.boolean "full_straight"
    t.boolean "mixed_outside_hand"
    t.boolean "three_concealed_triples"
    t.boolean "little_dragons"
    t.boolean "all_terminals_and_honors"
    t.boolean "three_color_triples"
    t.boolean "three_quads"
    t.boolean "hand_flush"
    t.boolean "pure_outside_hand"
    t.boolean "two_double_runs"
    t.boolean "full_flush"
    t.boolean "four_concealed_triples"
    t.boolean "thirteen_orphans"
    t.boolean "big_dragons"
    t.boolean "all_honors"
    t.boolean "all_terminals"
    t.boolean "blessing_of_earth"
    t.boolean "all_green"
    t.boolean "nine_gates"
    t.boolean "four_quads"
    t.string "blessing_of_heaven"
    t.boolean "open"
    t.integer "han"
    t.integer "hu"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "pure_nine_gates"
    t.boolean "suttan"
    t.boolean "all_waitting_thirteen_orphans"
    t.boolean "blessing_of_person"
    t.boolean "big_four_winds"
    t.boolean "small_four_winds"
    t.boolean "three_continuous_triples"
    t.boolean "four_continuous_triples"
    t.integer "pon"
    t.integer "chi"
    t.integer "ankan"
    t.integer "kakan"
    t.integer "minkan"
    t.boolean "tenpai"
  end

  create_table "results", force: :cascade do |t|
    t.integer "first_winner_user_id"
    t.integer "second_winner_user_id"
    t.integer "loser_user_id"
    t.boolean "drawn_game"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "first_leader_hand_id"
    t.integer "second_leader_hand_id"
    t.integer "third_leader_hand_id"
    t.integer "fourth_leader_hand_id"
  end

  create_table "user_scores", force: :cascade do |t|
    t.integer "user_id"
    t.integer "point"
    t.integer "chip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "half_round_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
