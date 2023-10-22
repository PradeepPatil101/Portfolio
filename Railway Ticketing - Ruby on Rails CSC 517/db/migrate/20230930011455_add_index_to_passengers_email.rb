class AddIndexToPassengersEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :passengers, :email, unique: true
  end
end
