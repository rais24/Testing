class CreateReimbursements < ActiveRecord::Migration
  def change
    create_table :reimbursements do |t|
      t.money    :discount
      t.decimal  :discount_percent,  	precision: 10, scale: 0
      t.string   :recurrence_frequency, null: false, default: "none"
      t.boolean  :active, null: false, default: true
      t.references :user
      t.timestamps    	
    end
  end
end
