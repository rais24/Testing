class AddStateToIngredient < ActiveRecord::Migration
  def change
    add_column :ingredients, :state, :string
  end
end
