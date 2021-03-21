# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_14_084439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "attachments", force: :cascade do |t|
    t.string "type", default: "png", null: false
    t.string "url", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "channels", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dislikes", force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "receiver_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_dislikes_on_profile_id"
    t.index ["receiver_id"], name: "index_dislikes_on_receiver_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "receiver_id"
    t.boolean "like_returned", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["profile_id"], name: "index_likes_on_profile_id"
    t.index ["receiver_id"], name: "index_likes_on_receiver_id"
  end

  create_table "locations", force: :cascade do |t|
    t.decimal "longitude"
    t.decimal "latitude"
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "city"
    t.string "address"
    t.index ["latitude", "longitude"], name: "index_locations_on_latitude_and_longitude"
    t.index ["profile_id"], name: "index_locations_on_profile_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "receiver_id", null: false
    t.bigint "attachment_id"
    t.bigint "channel_id", null: false
    t.datetime "read_at"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attachment_id"], name: "index_messages_on_attachment_id"
    t.index ["channel_id"], name: "index_messages_on_channel_id"
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
  end

  create_table "notification_push_locations", force: :cascade do |t|
    t.integer "location", null: false
    t.bigint "notification_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["notification_type_id"], name: "index_notification_push_locations_on_notification_type_id"
  end

  create_table "notification_senders", force: :cascade do |t|
    t.integer "sendable_id"
    t.string "sendable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sendable_id", "sendable_type"], name: "index_notification_senders_on_sendable_id_and_sendable_type"
  end

  create_table "notification_types", force: :cascade do |t|
    t.integer "name", null: false
    t.string "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "read_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "receiver_id"
    t.bigint "notification_type_id"
    t.index ["notification_type_id"], name: "index_notifications_on_notification_type_id"
    t.index ["receiver_id"], name: "index_notifications_on_receiver_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "channel_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_participants_on_channel_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "personality_type_logs", force: :cascade do |t|
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "preferences", force: :cascade do |t|
    t.integer "age_from"
    t.integer "age_to"
    t.float "distance"
    t.string "personality_type"
    t.string "show_me"
    t.string "distance_unit"
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["age_from", "age_to", "show_me"], name: "index_preferences_on_age_from_and_age_to_and_show_me"
    t.index ["distance", "distance_unit"], name: "index_preferences_on_distance_and_distance_unit"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "honorifics", limit: 10
    t.string "first_name", limit: 50
    t.string "middle_name", limit: 50
    t.string "last_name", limit: 100
    t.string "nickname", limit: 20
    t.datetime "date_of_birth"
    t.string "gender", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "full_name"
    t.string "personality_type"
    t.string "interested_in"
    t.string "height"
    t.string "drinking"
    t.string "smoking"
    t.string "work"
    t.string "education"
    t.string "religion"
    t.text "description"
    t.boolean "gold_member"
    t.boolean "boost"
    t.boolean "incognito"
    t.boolean "snooze_enable"
    t.string "snooze_time"
    t.string "include_me_in_search"
    t.index ["date_of_birth", "personality_type"], name: "index_profiles_on_date_of_birth_and_personality_type"
    t.index ["include_me_in_search"], name: "index_profiles_on_include_me_in_search"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "report_and_blocks", force: :cascade do |t|
    t.string "report_type"
    t.text "comment"
    t.integer "user_id"
    t.integer "block_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "translations", force: :cascade do |t|
    t.string "locale"
    t.string "key"
    t.text "value"
    t.text "interpolations"
    t.boolean "is_proc", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string "last_login_from_ip_address"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["last_logout_at", "last_activity_at"], name: "index_users_on_last_logout_at_and_last_activity_at"
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "messages", "users", column: "receiver_id"
  add_foreign_key "notifications", "notification_types"
  add_foreign_key "notifications", "users", column: "receiver_id"
  add_foreign_key "profiles", "users"
end
