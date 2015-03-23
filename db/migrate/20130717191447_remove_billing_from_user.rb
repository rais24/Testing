class RemoveBillingFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :billing_id, :integer
  end
end
