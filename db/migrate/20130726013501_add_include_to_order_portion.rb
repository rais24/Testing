class AddIncludeToOrderPortion < ActiveRecord::Migration
  def change
    add_column :order_portions, :include, :boolean, default: true, null: false
    OrderPortion.find_each(&:save!)
  end
end
