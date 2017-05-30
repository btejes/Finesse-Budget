class CreateBankAccounts < ActiveRecord::Migration
  create_table "bank_accounts" do |t|
    t.integer  "plaid_account_id", :null => false
    t.string "account_number", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bank_accounts", ["plaid_account_id"], :name => "index_bank_accounts_plaid_account_id"
end
