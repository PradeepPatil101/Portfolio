class AddRatingToTrains < ActiveRecord::Migration[6.1]
  def change
    add_column :trains, :rating, :decimal
  end
end
