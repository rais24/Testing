class AddShopriteConfirmationNameToStoreIngredient < ActiveRecord::Migration
  def change
    add_column :store_ingredients, :shoprite_confirmation_name, :string
  end
end
