class AddPublicTokenToPlaidAccount < ActiveRecord::Migration
  def change
    add_column :plaid_accounts, :public_token, :string
  end
end
