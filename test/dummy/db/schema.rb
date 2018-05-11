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

ActiveRecord::Schema.define(version: 2018_05_11_122123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.string "email"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lead_source"
    t.datetime "status_updated_at"
  end

  create_table "plumber_campaigns", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "record_class"
    t.string "delay_column"
  end

  create_table "plumber_messages", force: :cascade do |t|
    t.string "subject"
    t.text "body"
    t.integer "delay", default: 0
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.index ["campaign_id"], name: "index_plumber_messages_on_campaign_id"
    t.index ["delay"], name: "index_plumber_messages_on_delay"
  end

  create_table "plumber_sent_messages", force: :cascade do |t|
    t.string "record_type"
    t.bigint "record_id"
    t.bigint "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_plumber_sent_messages_on_message_id"
    t.index ["record_type", "record_id"], name: "index_plumber_sent_messages_on_record_type_and_record_id"
  end

  add_foreign_key "plumber_messages", "plumber_campaigns", column: "campaign_id", on_delete: :cascade
  add_foreign_key "plumber_sent_messages", "plumber_messages", column: "message_id", on_delete: :cascade
end
