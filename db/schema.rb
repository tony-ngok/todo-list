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

ActiveRecord::Schema[7.1].define(version: 2025_01_03_141241) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listes", force: :cascade do |t|
    t.string "listname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "todos", force: :cascade do |t|
    t.string "name"
    t.integer "done"
    t.integer "important"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "l_id"
    t.index ["l_id"], name: "index_todos_on_l_id"
  end

  add_foreign_key "todos", "listes", column: "l_id"
end
