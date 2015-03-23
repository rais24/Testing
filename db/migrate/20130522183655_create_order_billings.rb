class CreateOrderBillings < ActiveRecord::Migration
  def change
    create_table :order_billings do |t|
      t.boolean :charged, null: false, default: false
      t.boolean :updated, null: false, default: false
      t.boolean :canceled, null: false, default: false

      t.string :trans_id

      t.references :order
      t.references :billing

      t.timestamps
    end
  end
end
