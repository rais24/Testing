class DeliveriesPortionsJoin < ActiveRecord::Migration
  def up
    create_table :delivery_portions do |t|
      t.float :quantity, null: false, default: 0
      t.float :price,    null: false, default: 0

      t.references :delivery
      t.references :ingredient

      t.timestamps
    end
  end

  def down
    drop_table :delivery_portions
  end
end
