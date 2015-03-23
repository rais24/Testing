class CreateOrderPortions < ActiveRecord::Migration
  def up
    create_table :order_portions do |t|
      t.float :quantity, null: false, default: 0
      t.float :price,    null: false, default: 0

      t.references :order
      t.references :ingredient
      
      t.timestamps
    end
  end

  def down
    drop_table :order_portions
  end
end
