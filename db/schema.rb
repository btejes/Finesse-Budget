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

ActiveRecord::Schema.define(version: 20160709082208) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bank_accounts", force: :cascade do |t|
    t.integer  "plaid_account_id",                          null: false
    t.string   "account_number",                            null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "name"
    t.string   "ref_id"
    t.boolean  "considered"
    t.decimal  "balance",          precision: 12, scale: 2
    t.decimal  "available",        precision: 12, scale: 2
    t.string   "account_type"
    t.string   "account_subtype"
  end

  add_index "bank_accounts", ["plaid_account_id"], name: "index_bank_accounts_plaid_account_id", using: :btree

  create_table "plaid_accounts", force: :cascade do |t|
    t.string   "access_token", null: false
    t.integer  "user_id",      null: false
    t.string   "institution",  null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "public_token"
  end

  add_index "plaid_accounts", ["user_id"], name: "index_plaid_accounts_user_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "bank_account_id",         null: false
    t.string   "description",             null: false
    t.date     "date",                    null: false
    t.decimal  "amount",                  null: false
    t.integer  "month",                   null: false
    t.integer  "year",                    null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "ref_id"
    t.boolean  "pending"
    t.boolean  "ignore"
    t.integer  "transfer_transaction_id"
  end

  add_index "transactions", ["bank_account_id"], name: "index_transactions_bank_account_id", using: :btree
  add_index "transactions", ["ref_id"], name: "index_transactions_on_ref_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
    t.string   "push_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "transactions", "transactions", column: "transfer_transaction_id", on_delete: :nullify
end
