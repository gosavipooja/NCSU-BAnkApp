class CreateAccountCreationRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :account_creation_requests do |t|
      t.string :email
      t.string :status
      t.string :admin_email

      t.timestamps
    end
  end
end
