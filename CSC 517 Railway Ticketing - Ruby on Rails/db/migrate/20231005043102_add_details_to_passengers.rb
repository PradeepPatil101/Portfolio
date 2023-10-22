class AddDetailsToPassengers < ActiveRecord::Migration[6.1]
  def change
    add_column :passengers, :first_name, :string
    add_column :passengers, :last_name, :string
    add_column :passengers, :street_name, :string
    add_column :passengers, :street_name2, :string
    add_column :passengers, :city, :string
    add_column :passengers, :state, :string
    add_column :passengers, :zip, :string
  end
end
