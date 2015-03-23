class AddInsurerToUsers < ActiveRecord::Migration
  def change
	User.reset_column_information
	add_column(:users, :insurer, :string) unless User.column_names.include?('insurer')
	add_column(:users, :insurance_member_id, :string) unless User.column_names.include?('insurance_member_id')
	add_column(:users, :encrypted_insurer, :string) unless Billing.column_names.include?('encrypted_insurer')
	add_column(:users, :encrypted_insurance_member_id, :string) unless Billing.column_names.include?('encrypted_insurance_member_id')
  end
end
