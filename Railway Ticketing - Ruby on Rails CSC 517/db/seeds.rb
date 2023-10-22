# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(
  id: 1,
  username: 'admin',
  name: 'Admin User',
  email: 'admin@admin.com',
  password: 'password',
  phone_number: '123-456-7890',
  address: '123 Admin Street',
  credit_number: '1234-5678-9012-3456'
)