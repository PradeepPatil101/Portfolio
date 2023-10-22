class RemovePasswordFromPassengers < ActiveRecord::Migration[6.1]
  def change
    remove_column :passengers, :password, :string
  end
end
