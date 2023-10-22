class CreatePassengers < ActiveRecord::Migration[6.1]
  def change
    create_table :passengers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.string :phone_number
      t.string :address
      t.string :credit_card_info, null: false
      t.timestamps
    end
  end
end
