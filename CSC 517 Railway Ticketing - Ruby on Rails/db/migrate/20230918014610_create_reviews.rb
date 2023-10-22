class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :passenger, null: false, foreign_key: true
      t.references :train, null: false, foreign_key: true
      t.integer :rating
      t.text :feedback

      t.timestamps
    end
  end
end
