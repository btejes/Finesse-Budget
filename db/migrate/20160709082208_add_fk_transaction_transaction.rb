class AddFkTransactionTransaction < ActiveRecord::Migration
  def change
    add_foreign_key :transactions, :transactions, column: :transfer_transaction_id, on_delete: :nullify
  end
end
