class CreateOrderServings < ActiveRecord::Migration
  def up
    create_table :order_servings do |t|
      t.float :quantity, null: false, default: 0
      t.float :price,    null: false, default: 0

      t.references :order
      t.references :recipe

      t.timestamps
    end
  end

  def down
    drop_table :order_servings
  end
end
