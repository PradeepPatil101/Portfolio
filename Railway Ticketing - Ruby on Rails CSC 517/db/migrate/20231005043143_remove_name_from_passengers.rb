class RemoveNameFromPassengers < ActiveRecord::Migration[6.1]
  def change
    remove_column :passengers, :name, :string
  end
end
