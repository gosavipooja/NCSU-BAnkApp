class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.integer :account_number, limit: 8
      t.string :email
      t.integer :balance
      t.boolean :account_status

      t.timestamps
    end
    add_index :accounts, :account_number, unique: true
  end
end
