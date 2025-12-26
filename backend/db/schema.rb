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

ActiveRecord::Schema[8.0].define(version: 2025_12_25_214351) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "vector"

  create_table "abstrakte_abschlussarbeiten", force: :cascade do |t|
    t.string "betreuer"
    t.string "forschungsprojekt"
    t.string "semester"
    t.string "thema"
    t.string "themenskizze"
    t.integer "projekt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "embedding"
  end

  create_table "abstrakte_seminare", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "thema"
    t.text "beschreibung"
    t.uuid "mitarbeiter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "embedding"
    t.index ["mitarbeiter_id"], name: "index_abstrakte_seminare_on_mitarbeiter_id"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "content", null: false
    t.string "role", default: "user", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role"], name: "index_chat_messages_on_role"
    t.index ["user_id", "created_at"], name: "index_chat_messages_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_chat_messages_on_user_id"
  end

  create_table "klausuren", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "titel"
    t.string "modul"
    t.string "semester"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "embedding"
  end

  create_table "klausurergebnisse", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "punkte"
    t.float "note"
    t.string "status"
    t.date "pruefungsdatum"
    t.integer "versuche", default: 0
    t.bigint "student_id"
    t.uuid "klausur_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "embedding"
    t.index ["klausur_id"], name: "index_klausurergebnisse_on_klausur_id"
    t.index ["student_id"], name: "index_klausurergebnisse_on_student_id"
  end

  create_table "knowledge_entries", force: :cascade do |t|
    t.string "category", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.string "keywords"
    t.string "embedding"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_knowledge_entries_on_category"
    t.index ["title"], name: "index_knowledge_entries_on_title"
  end

  create_table "konkrete_abschlussarbeiten", force: :cascade do |t|
    t.string "betreuer"
    t.string "forschungsprojekt"
    t.string "semester"
    t.string "matrikelnummer"
    t.string "angepasste_themenskizze"
    t.string "gesetzte_schwerpunkte"
    t.date "anmeldung_pruefungsamt"
    t.date "abgabedatum"
    t.integer "studienniveau"
    t.bigint "student_id"
    t.bigint "abstrakte_abschlussarbeit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "embedding"
    t.integer "projekt_id"
    t.index ["abstrakte_abschlussarbeit_id"], name: "idx_on_abstrakte_abschlussarbeit_id_beb54b04c9"
    t.index ["student_id"], name: "index_konkrete_abschlussarbeiten_on_student_id"
  end

  create_table "mitarbeiter", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "vorname"
    t.string "nachname"
    t.string "email", null: false
    t.string "titel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_mitarbeiter_on_email", unique: true
  end

  create_table "seminare", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "titel"
    t.integer "aufnahmekapazitaet"
    t.string "semester"
    t.date "praesenzdatum"
    t.string "ort"
    t.uuid "mitarbeiter_id"
    t.uuid "abstraktes_seminar_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "embedding"
    t.index ["abstraktes_seminar_id"], name: "index_seminare_on_abstraktes_seminar_id"
    t.index ["mitarbeiter_id"], name: "index_seminare_on_mitarbeiter_id"
  end

  create_table "seminarergebnisse", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.float "muendlich_note"
    t.float "schriftlich_note"
    t.float "gesamt"
    t.integer "versuche", default: 0
    t.bigint "student_id"
    t.uuid "seminar_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seminar_id"], name: "index_seminarergebnisse_on_seminar_id"
    t.index ["student_id", "seminar_id"], name: "index_seminarergebnisse_on_student_id_and_seminar_id", unique: true
    t.index ["student_id"], name: "index_seminarergebnisse_on_student_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email"
    t.string "matrikelnummer"
    t.string "vorname"
    t.string "nachname"
    t.date "geburtsdatum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "abstrakte_seminare", "mitarbeiter"
  add_foreign_key "chat_messages", "students", column: "user_id"
  add_foreign_key "klausurergebnisse", "klausuren", column: "klausur_id"
  add_foreign_key "klausurergebnisse", "students"
  add_foreign_key "konkrete_abschlussarbeiten", "abstrakte_abschlussarbeiten", column: "abstrakte_abschlussarbeit_id"
  add_foreign_key "konkrete_abschlussarbeiten", "students"
  add_foreign_key "seminare", "abstrakte_seminare", column: "abstraktes_seminar_id"
  add_foreign_key "seminare", "mitarbeiter"
  add_foreign_key "seminarergebnisse", "seminare", column: "seminar_id"
  add_foreign_key "seminarergebnisse", "students"
  add_foreign_key "sessions", "users"
end
