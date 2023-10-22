class AddPurchaserAndRecipientToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :purchaser_id, :integer
    add_column :tickets, :recipient_id, :integer
  end
end
