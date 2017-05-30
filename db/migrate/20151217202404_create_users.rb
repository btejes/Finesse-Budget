class CreateUsers < ActiveRecord::Migration
  create_table "users" do |t|
    t.string  "email", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users", ["email"], :name => "index_users_email"
end
