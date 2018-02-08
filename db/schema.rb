# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180208230924) do

  create_table "scholarship_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "description"
    t.integer "category"
    t.float "max_amount", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scholarships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "person_type"
    t.bigint "person_id"
    t.float "amount", limit: 24
    t.date "start_date"
    t.date "end_date"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "scholarship_type_id"
    t.float "max_amount", limit: 24
    t.float "percent", limit: 24
    t.string "project_number"
    t.string "request_number"
    t.index ["person_id", "person_type"], name: "index_scholarships_on_person_id_and_person_type"
    t.index ["person_type", "person_id"], name: "index_scholarships_on_person_type_and_person_id"
    t.index ["scholarship_type_id"], name: "index_scholarships_on_scholarship_type_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "full_name"
    t.string "email"
    t.integer "user_type"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "scholarships", "scholarship_types"
end
