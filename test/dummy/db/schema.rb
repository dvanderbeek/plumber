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

ActiveRecord::Schema.define(version: 2018_05_10_155724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.string "email"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plumber_campaign_messages", force: :cascade do |t|
    t.bigint "message_id"
    t.bigint "campaign_id"
    t.integer "delay", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_plumber_campaign_messages_on_campaign_id"
    t.index ["delay"], name: "index_plumber_campaign_messages_on_delay"
    t.index ["message_id"], name: "index_plumber_campaign_messages_on_message_id"
  end

  create_table "plumber_campaigns", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "record_class"
  end

  create_table "plumber_entrances", force: :cascade do |t|
    t.bigint "campaign_id"
    t.string "record_type"
    t.bigint "record_id"
    t.boolean "exited", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_plumber_entrances_on_campaign_id"
    t.index ["record_type", "record_id"], name: "index_plumber_entrances_on_record_type_and_record_id"
  end

  create_table "plumber_messages", force: :cascade do |t|
    t.string "subject"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plumber_sent_messages", force: :cascade do |t|
    t.bigint "entrance_id"
    t.bigint "campaign_message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_message_id"], name: "index_plumber_sent_messages_on_campaign_message_id"
    t.index ["entrance_id"], name: "index_plumber_sent_messages_on_entrance_id"
  end

  add_foreign_key "plumber_campaign_messages", "plumber_campaigns", column: "campaign_id", on_delete: :cascade
  add_foreign_key "plumber_campaign_messages", "plumber_messages", column: "message_id", on_delete: :cascade
  add_foreign_key "plumber_entrances", "plumber_campaigns", column: "campaign_id", on_delete: :cascade
  add_foreign_key "plumber_sent_messages", "plumber_campaign_messages", column: "campaign_message_id", on_delete: :cascade
  add_foreign_key "plumber_sent_messages", "plumber_entrances", column: "entrance_id", on_delete: :cascade
end
