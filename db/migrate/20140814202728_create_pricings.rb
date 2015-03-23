class CreatePricings < ActiveRecord::Migration
  def change
    create_table :pricings do |t|
    	t.integer  :min_serving, null: false
    	t.integer  :max_serving, null: false
    	t.integer  :price_cents, null: false

	  	t.timestamps    	
    end
  end
end
