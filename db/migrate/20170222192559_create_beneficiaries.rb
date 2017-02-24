class CreateBeneficiaries < ActiveRecord::Migration[5.0]
  def change
    create_table :beneficiaries do |t|
      t.string :email
      t.integer :account, limit: 9
      t.string :nickname

      t.timestamps
    end
  end
end
