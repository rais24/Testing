class AddEncryptedFieldsToAddresses < ActiveRecord::Migration
  def change
	Address.reset_column_information
	add_column(:addresses, :encrypted_first_name, :text) unless Address.column_names.include?('encrypted_first_name')
	add_column(:addresses, :encrypted_last_name, :text) unless Address.column_names.include?('encrypted_last_name')
	add_column(:addresses, :encrypted_street1, :text) unless Address.column_names.include?('encrypted_street1')
	add_column(:addresses, :encrypted_street2, :text) unless Address.column_names.include?('encrypted_street2')
	add_column(:addresses, :encrypted_city, :text) unless Address.column_names.include?('encrypted_city')
	add_column(:addresses, :encrypted_state, :text) unless Address.column_names.include?('encrypted_state')
	add_column(:addresses, :encrypted_zipcode, :text) unless Address.column_names.include?('encrypted_zipcode')
	add_column(:addresses, :encrypted_phone, :text) unless Address.column_names.include?('encrypted_phone')
  end
end
