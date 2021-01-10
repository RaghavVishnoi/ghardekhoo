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

ActiveRecord::Schema.define(version: 2021_01_10_154632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "ad_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "advertisements", id: :serial, force: :cascade do |t|
    t.integer "retailer_id"
    t.integer "ad_type_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_url"
    t.integer "attachment_id"
  end

  create_table "cities", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.integer "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_sub_categories_id"
    t.text "description"
    t.index ["product_sub_categories_id"], name: "index_customers_on_product_sub_categories_id"
  end

  create_table "employees", id: :serial, force: :cascade do |t|
    t.string "ecode"
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.text "address"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "employees_roles", id: false, force: :cascade do |t|
    t.integer "employee_id"
    t.integer "role_id"
    t.index ["employee_id", "role_id"], name: "index_employees_roles_on_employee_id_and_role_id"
    t.index ["employee_id"], name: "index_employees_roles_on_employee_id"
    t.index ["role_id"], name: "index_employees_roles_on_role_id"
  end

  create_table "faqs", id: :serial, force: :cascade do |t|
    t.text "question"
    t.text "answer"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_product_categories_on_name"
  end

  create_table "product_operations", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_sub_categories", id: :serial, force: :cascade do |t|
    t.string "p_name"
    t.boolean "active", default: true
    t.integer "product_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "retailer_photos", id: :serial, force: :cascade do |t|
    t.string "photo_url"
    t.string "lat"
    t.string "lng"
    t.integer "retailer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "main"
    t.integer "attachment_id"
    t.index ["main"], name: "index_retailer_photos_on_main"
  end

  create_table "retailer_product_categories", id: :serial, force: :cascade do |t|
    t.integer "retailer_id"
    t.integer "product_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "retailer_product_photos", id: :serial, force: :cascade do |t|
    t.string "photo_url"
    t.string "lat"
    t.string "lng"
    t.integer "retailer_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "attachment_id"
  end

  create_table "retailer_product_reviews", force: :cascade do |t|
    t.string "review"
    t.float "rating"
    t.integer "retailer_product_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "retailer_products", id: :serial, force: :cascade do |t|
    t.string "sku_code"
    t.string "product_name"
    t.decimal "min_price"
    t.integer "retailer_id"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_sub_category_id"
    t.text "description"
    t.integer "status", default: 0
    t.string "unit"
    t.string "city"
    t.string "state"
    t.integer "priority"
    t.boolean "main", default: false
    t.integer "max_price"
    t.datetime "upload_date"
    t.integer "product_type_id"
    t.text "address"
    t.string "access_token"
    t.integer "product_operation_id"
    t.index ["status"], name: "index_retailer_products_on_status"
  end

  create_table "retailer_reviews", id: :serial, force: :cascade do |t|
    t.integer "retailer_id"
    t.integer "user_id"
    t.text "review"
    t.float "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rating"], name: "index_retailer_reviews_on_rating"
  end

  create_table "retailers", id: :serial, force: :cascade do |t|
    t.string "gst_number"
    t.string "adhaar_number"
    t.string "pan_number"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "email"
    t.text "address"
    t.string "city"
    t.string "state"
    t.string "country"
    t.decimal "lat"
    t.decimal "lng"
    t.integer "employee_id"
    t.boolean "active", default: true
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.string "photo_url"
    t.string "account_type"
    t.integer "account_status", default: 0
    t.string "username"
    t.text "about_business"
    t.float "rating"
    t.string "access_token"
    t.index ["rating"], name: "index_retailers_on_rating"
    t.index ["reset_password_token"], name: "index_retailers_on_reset_password_token", unique: true
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "states", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_request_replies", force: :cascade do |t|
    t.integer "user_request_id"
    t.integer "user_id"
    t.integer "admin_id"
    t.string "replied_by"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_requests", id: :serial, force: :cascade do |t|
    t.integer "product_category_id"
    t.integer "product_sub_category_id"
    t.string "subject"
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.string "number"
    t.boolean "active", default: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "encrypted_password"
    t.string "phone"
    t.string "age"
    t.string "photo_url"
    t.string "gender"
    t.string "bio"
    t.string "facebook_user_id"
    t.string "facebook_user_token"
    t.string "token"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "lat"
    t.float "lng"
    t.string "username"
    t.string "google_user_id"
    t.index ["email"], name: "index_users_on_email", unique: true, where: "(email IS NOT NULL)"
    t.index ["facebook_user_id"], name: "index_users_on_facebook_user_id", unique: true, where: "(facebook_user_id IS NOT NULL)"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "advertisements", "ad_types"
  add_foreign_key "advertisements", "retailers"
  add_foreign_key "cities", "states"
  add_foreign_key "product_sub_categories", "product_categories"
  add_foreign_key "retailer_photos", "retailers"
  add_foreign_key "retailer_product_categories", "product_categories"
  add_foreign_key "retailer_product_categories", "retailers"
  add_foreign_key "retailer_product_photos", "retailer_products"
  add_foreign_key "retailer_product_reviews", "retailer_products"
  add_foreign_key "retailer_product_reviews", "users"
  add_foreign_key "retailer_products", "product_operations"
  add_foreign_key "retailer_products", "product_sub_categories"
  add_foreign_key "retailer_products", "product_types"
  add_foreign_key "retailer_products", "retailers"
  add_foreign_key "retailer_reviews", "retailers"
  add_foreign_key "retailer_reviews", "users"
  add_foreign_key "user_request_replies", "admins"
  add_foreign_key "user_request_replies", "user_requests"
  add_foreign_key "user_request_replies", "users"
  add_foreign_key "user_requests", "product_categories"
  add_foreign_key "user_requests", "product_sub_categories"
  add_foreign_key "user_requests", "users"
end
