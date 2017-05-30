class AddTransactionIgnore < ActiveRecord::Migration
  def change
    add_column :transactions, :ignore, :boolean
  end
end
