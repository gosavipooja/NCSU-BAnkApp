class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_id
      t.integer :amount
      t.integer :credited_acc_number, limit: 8
      t.integer :debited_acc_number, limit: 8
      t.string :admin_email
      t.string :transaction_status
      t.string :transaction_type

      t.timestamps
    end
    add_index :transactions, :transaction_id, unique: true
  end
end
