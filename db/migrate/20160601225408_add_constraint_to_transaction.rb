class AddConstraintToTransaction < ActiveRecord::Migration
  def change
    add_index :transactions, :ref_id, unique: true
  end
end
