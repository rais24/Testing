class AddEncryptionToBillings < ActiveRecord::Migration
  def change
	Billing.reset_column_information
	add_column(:billings, :encrypted_expiration_month, :text) unless Billing.column_names.include?('encrypted_expiration_month')
	add_column(:billings, :encrypted_expiration_year, :text) unless Billing.column_names.include?('encrypted_expiration_year')
	add_column(:billings, :encrypted_last_4, :text) unless Billing.column_names.include?('encrypted_last_4')
	add_column(:billings, :encrypted_name, :text) unless Billing.column_names.include?('encrypted_name')
	add_column(:billings, :encrypted_card_type, :text) unless Billing.column_names.include?('encrypted_card_type')
  end
end
