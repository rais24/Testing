class AddSubscriptionToBillings < ActiveRecord::Migration
  def change
 	Billing.reset_column_information
    add_column(:billings, :subscription_id, :integer) unless Billing.column_names.include?('subscription_id')
  end
end
