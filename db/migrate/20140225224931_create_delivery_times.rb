class CreateDeliveryTimes < ActiveRecord::Migration
  def change
    create_table :delivery_times do |t|
      t.date :delivery_date
      t.string :time_slot
      
      t.references :order

      t.timestamps
    end
  end
end

