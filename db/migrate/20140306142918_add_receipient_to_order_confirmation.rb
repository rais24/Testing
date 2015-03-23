class AddReceipientToOrderConfirmation < ActiveRecord::Migration
  def change
    add_column :order_confirmations, :recipient, :string
  end
end
