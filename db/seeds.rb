# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(name: "admin", email: "admin@ncsu.edu", password_field: "admin", is_pre_admin: true)
Admin.create!(name: "user", email: "user@ncsu.edu", password_field: "password", is_pre_admin: true)
Account.create!(email: "sunil@sunil.com", account_number: 900000000, balance: 100, account_status: true)