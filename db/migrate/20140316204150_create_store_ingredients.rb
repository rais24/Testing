class CreateStoreIngredients < ActiveRecord::Migration
  def change
    create_table :store_ingredients do |t|
      t.string :name
      t.string :brand
      t.string :sku
      t.decimal :amount
      t.string :unit

      t.timestamps
    end
  end
end
