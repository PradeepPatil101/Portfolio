class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :password
      t.string :phone_number
      t.text :address
      t.string :credit_number

      t.timestamps
    end
  end
end
