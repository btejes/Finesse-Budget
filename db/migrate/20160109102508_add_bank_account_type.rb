class AddBankAccountType < ActiveRecord::Migration
  def change
    add_column :bank_accounts, :account_type, :string
    add_column :bank_accounts, :account_subtype, :string
  end
end
