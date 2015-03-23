class AddSubtotalToOrder < ActiveRecord::Migration
  def change
    add_money :orders, :subtotal
  end
end
