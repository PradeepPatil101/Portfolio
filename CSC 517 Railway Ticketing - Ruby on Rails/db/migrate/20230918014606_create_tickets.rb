class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.references :passenger, null: false, foreign_key: true
      t.references :train, null: false, foreign_key: true
      t.string :confirmation_number

      t.timestamps
    end
  end
end
