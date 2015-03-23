class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.float :price, null: false, default: 0
      t.string :unit, null: false
      t.string :category

      t.attachment :photo

      t.timestamps
    end
  end
end
