class AddTransferTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :transfer_transaction_id, :integer
  end
end
