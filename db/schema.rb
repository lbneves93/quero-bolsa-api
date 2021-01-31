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

ActiveRecord::Schema.define(version: 2021_01_31_024749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "campus", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "university_id", null: false
    t.string "name", null: false
    t.string "city", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["university_id"], name: "index_campus_on_university_id"
  end

  create_table "campus_courses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "campus_id"
    t.uuid "course_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["campus_id"], name: "index_campus_courses_on_campus_id"
    t.index ["course_id"], name: "index_campus_courses_on_course_id"
  end

  create_table "courses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "kind", null: false
    t.string "level", null: false
    t.string "shift", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "offers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "course_id", null: false
    t.decimal "full_price", precision: 10, scale: 2, null: false
    t.decimal "price_with_discount", precision: 10, scale: 2, null: false
    t.decimal "discount_percentage", precision: 5, null: false
    t.date "start_date", null: false
    t.string "enrollment_semester", null: false
    t.boolean "enabled", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "campus_id"
    t.index ["campus_id"], name: "index_offers_on_campus_id"
    t.index ["course_id"], name: "index_offers_on_course_id"
  end

  create_table "universities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.decimal "score", precision: 10, scale: 2, null: false
    t.string "logo_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.integer "age"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "campus", "universities"
  add_foreign_key "offers", "campus", column: "campus_id"
  add_foreign_key "offers", "courses"
end
