class AddCheckedOutToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :checked_out, :boolean, default: false, null: false
    add_index :orders, :checked_out
  end
end
