class CreateStoreIngredientOrderAssociations < ActiveRecord::Migration
  def change
    create_table :order_store_ingredients do |t|
      t.belongs_to :order
      t.belongs_to :store_ingredient
      t.timestamps
    end
  end
end
