class AddCashbackToOrderProducts < ActiveRecord::Migration
  def change
 	OrderProduct.reset_column_information
    add_column(:order_products, :cashback, :boolean) unless OrderProduct.column_names.include?('cashback')
  end
end
