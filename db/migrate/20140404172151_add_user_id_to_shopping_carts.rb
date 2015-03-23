class AddUserIdToShoppingCarts < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :user_id, :integer
  end
end
