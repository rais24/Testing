class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      
      t.datetime :scheduled_for
      t.datetime :delivered_at

      t.string :status, null: false, default: :pending
      t.float :price

      t.references :delivery_site

      t.timestamps
    end
  end
end
