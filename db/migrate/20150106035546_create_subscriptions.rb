class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :subscription_type, null: false, default: "3-day"
      t.datetime :expires_on, null: false
      t.datetime :paused_on
      t.datetime :resumes_on
      t.string :delivery_day, null: false
      t.string :delivery_time_slot, null: false
      t.string :status, null: false, default: "active"
      t.references :user

      t.timestamps
    end
  end
end
