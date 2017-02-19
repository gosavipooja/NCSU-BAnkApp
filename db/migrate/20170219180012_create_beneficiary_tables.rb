class CreateBeneficiaryTables < ActiveRecord::Migration[5.0]
  def change
    create_table :beneficiary_tables do |t|
      t.string :email
      t.integer :beneficiary_acc_number, limit: 9
      t.string :beneficiary_nick_name

      t.timestamps
    end
  end
end
