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

ActiveRecord::Schema.define(version: 20190217090623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ad_types", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "advertisements", force: :cascade do |t|
    t.integer  "retailer_id"
    t.integer  "ad_type_id"
    t.boolean  "active",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "photo_url"
  end

  create_table "employees", force: :cascade do |t|
    t.string   "ecode"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "", null: false
    t.text     "address"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_employees_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree
  end

  create_table "employees_roles", id: false, force: :cascade do |t|
    t.integer "employee_id"
    t.integer "role_id"
    t.index ["employee_id", "role_id"], name: "index_employees_roles_on_employee_id_and_role_id", using: :btree
    t.index ["employee_id"], name: "index_employees_roles_on_employee_id", using: :btree
    t.index ["role_id"], name: "index_employees_roles_on_role_id", using: :btree
  end

  create_table "faqs", force: :cascade do |t|
    t.text     "question"
    t.text     "answer"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["name"], name: "index_product_categories_on_name", using: :btree
  end

  create_table "product_sub_categories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",              default: true
    t.integer  "product_category_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "retailer_photos", force: :cascade do |t|
    t.string   "photo_url"
    t.string   "lat"
    t.string   "lng"
    t.integer  "retailer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "main"
    t.index ["main"], name: "index_retailer_photos_on_main", using: :btree
  end

  create_table "retailer_product_categories", force: :cascade do |t|
    t.integer  "retailer_id"
    t.integer  "product_category_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "retailer_product_photos", force: :cascade do |t|
    t.string   "photo_url"
    t.string   "lat"
    t.string   "lng"
    t.integer  "retailer_product_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "retailer_products", force: :cascade do |t|
    t.string   "sku_code"
    t.string   "product_name"
    t.decimal  "price"
    t.integer  "retailer_id"
    t.boolean  "active"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "product_sub_category_id"
    t.text     "description"
    t.integer  "status",                  default: 0
    t.index ["status"], name: "index_retailer_products_on_status", using: :btree
  end

  create_table "retailer_reviews", force: :cascade do |t|
    t.integer  "retailer_id"
    t.integer  "user_id"
    t.text     "review"
    t.float    "rating"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["rating"], name: "index_retailer_reviews_on_rating", using: :btree
  end

  create_table "retailers", force: :cascade do |t|
    t.string   "gst_number"
    t.string   "adhaar_number"
    t.string   "pan_number"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.text     "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.decimal  "lat"
    t.decimal  "lng"
    t.integer  "employee_id"
    t.boolean  "active",                 default: true
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "token"
    t.string   "photo_url"
    t.string   "account_type"
    t.integer  "account_status",         default: 0
    t.string   "username"
    t.text     "about_business"
    t.float    "rating"
    t.index ["rating"], name: "index_retailers_on_rating", using: :btree
    t.index ["reset_password_token"], name: "index_retailers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id", using: :btree
  end

  create_table "user_requests", force: :cascade do |t|
    t.integer  "product_category_id"
    t.integer  "product_sub_category_id"
    t.string   "subject"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "status"
    t.string   "number"
    t.boolean  "active",                  default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "phone"
    t.string   "age"
    t.string   "photo_url"
    t.string   "gender"
    t.string   "bio"
    t.string   "facebook_user_id"
    t.string   "facebook_user_token"
    t.string   "token"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.float    "lat"
    t.float    "lng"
    t.string   "username"
    t.string   "google_user_id"
    t.index ["email"], name: "index_users_on_email", unique: true, where: "(email IS NOT NULL)", using: :btree
    t.index ["facebook_user_id"], name: "index_users_on_facebook_user_id", unique: true, where: "(facebook_user_id IS NOT NULL)", using: :btree
  end

  add_foreign_key "advertisements", "ad_types"
  add_foreign_key "advertisements", "retailers"
  add_foreign_key "product_sub_categories", "product_categories"
  add_foreign_key "retailer_photos", "retailers"
  add_foreign_key "retailer_product_categories", "product_categories"
  add_foreign_key "retailer_product_categories", "retailers"
  add_foreign_key "retailer_product_photos", "retailer_products"
  add_foreign_key "retailer_products", "product_sub_categories"
  add_foreign_key "retailer_products", "retailers"
  add_foreign_key "retailer_reviews", "retailers"
  add_foreign_key "retailer_reviews", "users"
  add_foreign_key "user_requests", "product_categories"
  add_foreign_key "user_requests", "product_sub_categories"
  add_foreign_key "user_requests", "users"
end
