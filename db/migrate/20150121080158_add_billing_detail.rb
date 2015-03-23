class AddBillingDetail < ActiveRecord::Migration
  def change
	Billing.reset_column_information
	add_column(:billings, :card_number, :string) unless Billing.column_names.include?('card_number')
	add_column(:billings, :encrypted_card_number, :text) unless Billing.column_names.include?('encrypted_card_number')
	add_column(:billings, :card_code, :string) unless Billing.column_names.include?('card_code')
	add_column(:billings, :encrypted_card_code, :text) unless Billing.column_names.include?('encrypted_card_code')
  end
end
