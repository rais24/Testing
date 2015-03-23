class CreateRecipePortions < ActiveRecord::Migration
  def up
    create_table :recipe_portions do |t|
      t.float :quantity, null: false, default: 0
      t.float :price,    null: false, default: 0

      t.references :ingredient
      t.references :recipe

      t.timestamps
    end
  end

  def down
    drop_table :recipe_portions
  end
end
