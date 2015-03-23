class AddBusinessNameToUsers < ActiveRecord::Migration
  def change
	User.reset_column_information
	add_column(:users, :business_name, :string) unless User.column_names.include?('business_name')
	add_column(:users, :encrypted_business_name, :string) unless User.column_names.include?('encrypted_business_name')
  end
end
