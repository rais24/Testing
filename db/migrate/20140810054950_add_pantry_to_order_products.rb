class AddPantryToOrderProducts < ActiveRecord::Migration
  def change
  	OrderProduct.reset_column_information
    add_column(:order_products, :pantry, :boolean) unless OrderProduct.column_names.include?('pantry')
  end
end
