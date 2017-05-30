class AddTransactionRefId < ActiveRecord::Migration
  def change
    add_column :transactions, :ref_id, :string
    add_column :transactions, :pending, :boolean
  end
end
