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

ActiveRecord::Schema[8.1].define(version: 2026_10_19_163314) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "adventures", force: :cascade do |t|
    t.integer "booking_id", null: false
    t.integer "user_id", null: false
    t.string "title"
    t.text "body"
    t.string "location_text"
    t.date "happened_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_adventures_on_booking_id"
    t.index ["user_id"], name: "index_adventures_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "listing_id", null: false
    t.integer "renter_id", null: false
    t.date "start_on", null: false
    t.date "end_on", null: false
    t.integer "status", default: 0, null: false
    t.integer "daily_rate_cents"
    t.integer "days"
    t.integer "subtotal_cents"
    t.integer "deposit_cents"
    t.datetime "approved_at"
    t.datetime "declined_at"
    t.datetime "picked_up_at"
    t.datetime "returned_at"
    t.datetime "cancelled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_bookings_on_listing_id"
    t.index ["renter_id"], name: "index_bookings_on_renter_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_categories_on_parent_id"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "gear_logs", force: :cascade do |t|
    t.integer "listing_id", null: false
    t.integer "kind", default: 0, null: false
    t.text "body"
    t.date "happened_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_gear_logs_on_listing_id"
  end

  create_table "kudos", force: :cascade do |t|
    t.integer "giver_id", null: false
    t.integer "receiver_id", null: false
    t.integer "booking_id"
    t.integer "adventure_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["adventure_id"], name: "index_kudos_on_adventure_id"
    t.index ["booking_id"], name: "index_kudos_on_booking_id"
    t.index ["giver_id"], name: "index_kudos_on_giver_id"
    t.index ["receiver_id"], name: "index_kudos_on_receiver_id"
  end

  create_table "listings", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.integer "category_id", null: false
    t.string "title", null: false
    t.text "description"
    t.string "brand"
    t.integer "condition", default: 0, null: false
    t.boolean "safety_critical", default: false, null: false
    t.integer "price_per_day_cents", default: 0, null: false
    t.integer "deposit_cents", default: 0, null: false
    t.string "location_text", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_listings_on_category_id"
    t.index ["owner_id"], name: "index_listings_on_owner_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "booking_id", null: false
    t.integer "reviewer_id", null: false
    t.integer "reviewee_id", null: false
    t.integer "rating", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id", "reviewer_id"], name: "index_reviews_on_booking_id_and_reviewer_id", unique: true
    t.index ["booking_id"], name: "index_reviews_on_booking_id"
    t.index ["reviewee_id"], name: "index_reviews_on_reviewee_id"
    t.index ["reviewer_id"], name: "index_reviews_on_reviewer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "provider"
    t.string "uid"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "adventures", "bookings"
  add_foreign_key "adventures", "users"
  add_foreign_key "bookings", "listings"
  add_foreign_key "bookings", "users", column: "renter_id"
  add_foreign_key "categories", "categories", column: "parent_id"
  add_foreign_key "gear_logs", "listings"
  add_foreign_key "kudos", "adventures"
  add_foreign_key "kudos", "bookings"
  add_foreign_key "kudos", "users", column: "giver_id"
  add_foreign_key "kudos", "users", column: "receiver_id"
  add_foreign_key "listings", "categories"
  add_foreign_key "listings", "users", column: "owner_id"
  add_foreign_key "reviews", "bookings"
  add_foreign_key "reviews", "users", column: "reviewee_id"
  add_foreign_key "reviews", "users", column: "reviewer_id"
end
