class CreateOrderConfirmations < ActiveRecord::Migration
  def change
    create_table :order_confirmations do |t|
      t.integer :order_id
      t.string :supplier
      t.text :raw_message
      t.datetime :send_date

      t.timestamps
    end
  end
end
