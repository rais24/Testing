class CreateUsedPromos < ActiveRecord::Migration
  def change
    create_table :used_promos do |t|
      t.integer :promo_id
      t.integer :order_id
      t.integer :shopping_cart_id

      t.timestamps
    end
  end
end
