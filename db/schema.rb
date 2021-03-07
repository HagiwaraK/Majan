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

ActiveRecord::Schema.define(version: 2021_03_07_200212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer "honba"
    t.string "round"
    t.integer "first_leader_score"
    t.integer "second_leader_score"
    t.integer "third_leader_score"
    t.integer "fourth_leader_score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "half_rounds", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "results", force: :cascade do |t|
    t.integer "first_winner"
    t.integer "second_winner"
    t.integer "loser"
    t.boolean "drawn_game"
    t.boolean "first_leader_waiting"
    t.boolean "second_leader_waiting"
    t.boolean "third_leader_waiting"
    t.boolean "fourth_leader_waiting"
    t.integer "first_winner_hand"
    t.integer "second_winner_hand"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_scores", force: :cascade do |t|
    t.integer "user_id"
    t.integer "point"
    t.integer "tip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
