class AddCompletedToShoppingCart < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :completed, :boolean, default: false
  end
end
