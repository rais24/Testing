class AddDiscountsToPromo < ActiveRecord::Migration
  def change
    add_money :promos, :discount
    add_column :promos, :discount_percent, :decimal
  end
end
