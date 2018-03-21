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

ActiveRecord::Schema.define(version: 20180321181143) do

  create_table "audits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "scholarship_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "person_type"
    t.bigint "person_id"
    t.string "content"
    t.integer "status"
    t.bigint "scholarship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id", "person_type"], name: "index_scholarship_comments_on_person_id_and_person_type"
    t.index ["person_type", "person_id"], name: "index_scholarship_comments_on_person_type_and_person_id"
    t.index ["scholarship_id"], name: "index_scholarship_comments_on_scholarship_id"
  end

  create_table "scholarship_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "scholarship_id"
    t.string "token"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scholarship_id"], name: "index_scholarship_tokens_on_scholarship_id"
  end

  create_table "scholarship_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "description"
    t.integer "category"
    t.float "max_amount", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
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
    t.string "areas"
  end

  add_foreign_key "scholarship_comments", "scholarships"
  add_foreign_key "scholarships", "scholarship_types"
end
