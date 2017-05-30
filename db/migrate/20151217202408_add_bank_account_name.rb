class AddBankAccountName < ActiveRecord::Migration
  def change
    add_column :bank_accounts, :name, :string
    add_column :bank_accounts, :ref_id, :string
    add_column :bank_accounts, :considered, :boolean
    add_column :bank_accounts, :balance, :decimal, precision: 12, scale: 2
    add_column :bank_accounts, :available, :decimal, precision: 12, scale: 2
  end
end
