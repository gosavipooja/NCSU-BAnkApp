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

ActiveRecord::Schema.define(version: 20170222192559) do

  create_table "account_creation_requests", force: :cascade do |t|
    t.string   "email"
    t.string   "status"
    t.string   "admin_email"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.integer  "account_number", limit: 9
    t.string   "email"
    t.integer  "balance"
    t.boolean  "account_status"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["account_number"], name: "index_accounts_on_account_number", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.boolean  "is_pre_admin"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "beneficiaries", force: :cascade do |t|
    t.string   "email"
    t.integer  "account",    limit: 9
    t.string   "nickname"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "beneficiary_tables", force: :cascade do |t|
    t.string   "email"
    t.integer  "beneficiary_acc_number", limit: 9
    t.string   "beneficiary_nick_name"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "transaction_id"
    t.integer  "amount"
    t.integer  "credited_acc_number", limit: 9
    t.integer  "debited_acc_number",  limit: 9
    t.string   "admin_email"
    t.string   "transaction_status"
    t.string   "transaction_type"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["transaction_id"], name: "index_transactions_on_transaction_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.text     "address"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end