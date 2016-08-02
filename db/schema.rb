# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160802102646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.string   "erf"
    t.string   "unit"
    t.string   "complex"
    t.string   "street_number"
    t.string   "street_name"
    t.string   "suburb"
    t.string   "city"
    t.string   "post_code"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree
  end

  create_table "agents", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "employee_number"
    t.string   "mobile"
    t.string   "email"
    t.integer  "tax_percent"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "ahoy_messages", force: :cascade do |t|
    t.string   "token"
    t.text     "to"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "mailer"
    t.text     "subject"
    t.text     "content"
    t.datetime "sent_at"
    t.datetime "opened_at"
    t.datetime "clicked_at"
    t.index ["token"], name: "index_ahoy_messages_on_token", using: :btree
    t.index ["user_id", "user_type"], name: "index_ahoy_messages_on_user_id_and_user_type", using: :btree
  end

  create_table "attorneys", force: :cascade do |t|
    t.string   "name"
    t.string   "telephone"
    t.string   "email"
    t.boolean  "preferred"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "banks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commissions", force: :cascade do |t|
    t.integer  "agent_id"
    t.string   "commissionable_type"
    t.integer  "commissionable_id"
    t.integer  "agent_percent"
    t.decimal  "commission_amount",   precision: 14, scale: 2
    t.integer  "tax_percent"
    t.decimal  "tax_amount",          precision: 14, scale: 2
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["agent_id"], name: "index_commissions_on_agent_id", using: :btree
    t.index ["commissionable_type", "commissionable_id"], name: "index_commissions_on_commissionable_type_and_commissionable_id", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "company"
  end

  create_table "deductables", force: :cascade do |t|
    t.string   "name"
    t.decimal  "default_cost", precision: 10, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "deductions", force: :cascade do |t|
    t.integer  "commission_id"
    t.string   "name"
    t.integer  "deductable_id"
    t.decimal  "total_amount",  precision: 14, scale: 2
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["commission_id"], name: "index_deductions_on_commission_id", using: :btree
    t.index ["deductable_id"], name: "index_deductions_on_deductable_id", using: :btree
  end

  create_table "leases", force: :cascade do |t|
    t.string   "reference"
    t.string   "payprop_reference"
    t.decimal  "rent_amount",         precision: 14, scale: 2
    t.boolean  "managed"
    t.date     "start_on"
    t.date     "end_on"
    t.decimal  "deposit_amount",      precision: 14, scale: 2
    t.string   "deposit_held_by"
    t.integer  "lessor_id"
    t.integer  "lessee_id"
    t.decimal  "lease_fee",           precision: 14, scale: 2
    t.decimal  "inspection_fee",      precision: 14, scale: 2
    t.decimal  "credit_check_fee",    precision: 14, scale: 2
    t.date     "credit_check_on"
    t.date     "deposit_released_on"
    t.string   "deposit_released_to"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "agent_id"
    t.index ["agent_id"], name: "index_leases_on_agent_id", using: :btree
    t.index ["lessee_id"], name: "index_leases_on_lessee_id", using: :btree
    t.index ["lessor_id"], name: "index_leases_on_lessor_id", using: :btree
  end

  create_table "originators", force: :cascade do |t|
    t.string   "name"
    t.string   "telephone"
    t.string   "email"
    t.boolean  "preferred"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rentals", force: :cascade do |t|
    t.integer  "lease_id"
    t.date     "received_on"
    t.decimal  "amount_received",   precision: 14, scale: 2
    t.decimal  "commission_amount", precision: 14, scale: 2
    t.decimal  "tax_amount",        precision: 14, scale: 2
    t.decimal  "fees_amount",       precision: 14, scale: 2
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "import_id"
    t.index ["lease_id"], name: "index_rentals_on_lease_id", using: :btree
  end

  create_table "sales", force: :cascade do |t|
    t.string   "reference"
    t.integer  "seller_id"
    t.integer  "buyer_id"
    t.date     "contract_start_on"
    t.decimal  "purchase_price",    precision: 14, scale: 2
    t.decimal  "deposit_amount",    precision: 14, scale: 2
    t.date     "deposit_due_on"
    t.integer  "attorney_id"
    t.integer  "bond_attorney_id"
    t.date     "bond_due_on"
    t.integer  "originator_id"
    t.integer  "status_id"
    t.date     "registered_on"
    t.integer  "bank_id"
    t.decimal  "grant_amount",      precision: 14, scale: 2
    t.decimal  "commission_amount", precision: 14, scale: 2
    t.decimal  "tax_amount",        precision: 14, scale: 2
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.text     "comments"
    t.index ["attorney_id"], name: "index_sales_on_attorney_id", using: :btree
    t.index ["bank_id"], name: "index_sales_on_bank_id", using: :btree
    t.index ["bond_attorney_id"], name: "index_sales_on_bond_attorney_id", using: :btree
    t.index ["buyer_id"], name: "index_sales_on_buyer_id", using: :btree
    t.index ["originator_id"], name: "index_sales_on_originator_id", using: :btree
    t.index ["seller_id"], name: "index_sales_on_seller_id", using: :btree
    t.index ["status_id"], name: "index_sales_on_status_id", using: :btree
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.string   "nature"
    t.boolean  "can_edit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

  add_foreign_key "commissions", "agents"
  add_foreign_key "deductions", "commissions"
  add_foreign_key "deductions", "deductables"
  add_foreign_key "leases", "agents"
  add_foreign_key "rentals", "leases"
  add_foreign_key "sales", "attorneys"
  add_foreign_key "sales", "attorneys", column: "bond_attorney_id"
  add_foreign_key "sales", "banks"
  add_foreign_key "sales", "contacts", column: "buyer_id"
  add_foreign_key "sales", "contacts", column: "seller_id"
  add_foreign_key "sales", "originators"
  add_foreign_key "sales", "statuses"
end
