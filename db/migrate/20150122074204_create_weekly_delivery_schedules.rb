class CreateWeeklyDeliverySchedules < ActiveRecord::Migration
  def change
    create_table :weekly_delivery_schedules do |t|
      t.string :delivery_day
      t.string :time_slot
	  t.string :delivery_instructions      
      t.references :subscription
      t.references :user
      t.timestamps
    end
  end
end
