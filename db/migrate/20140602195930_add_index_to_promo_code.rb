class AddIndexToPromoCode < ActiveRecord::Migration
  def change
    add_index :promos, :code
  end
end
