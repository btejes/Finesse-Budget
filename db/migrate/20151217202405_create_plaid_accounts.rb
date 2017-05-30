class CreatePlaidAccounts < ActiveRecord::Migration
  create_table "plaid_accounts" do |t|
    t.string  "access_token", :null => false
    t.integer "user_id", :null => false
    t.string "institution", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "plaid_accounts", ["user_id"], :name => "index_plaid_accounts_user_id"
end
