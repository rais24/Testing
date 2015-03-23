class CreateOrderSubstitutions < ActiveRecord::Migration
  def change
    create_table :order_substitutions do |t|
			t.integer  :order_id, null: false
			t.string   :original_sku, null: false
			t.string   :substituted_confirmation_name, null: false
			t.string	 :substituted_sku, null: false
			t.string	 :quantity, null: false
			t.timestamps
    end
  end
end
