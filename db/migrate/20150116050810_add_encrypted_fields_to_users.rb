class AddEncryptedFieldsToUsers < ActiveRecord::Migration
  def change
	User.reset_column_information
	add_column(:users, :encrypted_first, :text) unless User.column_names.include?('encrypted_first')
	add_column(:users, :encrypted_last, :text) unless User.column_names.include?('encrypted_last')
	add_column(:users, :encrypted_adults, :text) unless User.column_names.include?('encrypted_adults')
	add_column(:users, :encrypted_children, :text) unless User.column_names.include?('encrypted_children')
	add_column(:users, :encrypted_invite_code, :text) unless User.column_names.include?('encrypted_invite_code')
	add_column(:users, :encrypted_weight, :text) unless User.column_names.include?('encrypted_weight')
	add_column(:users, :encrypted_height, :text) unless User.column_names.include?('encrypted_weight')
	add_column(:users, :encrypted_practitioner_code, :text) unless User.column_names.include?('encrypted_practitioner_code')
	add_column(:users, :encrypted_dob, :text) unless User.column_names.include?('encrypted_dob')
	add_column(:users, :encrypted_gender, :text) unless User.column_names.include?('encrypted_gender')
	add_column(:users, :encrypted_dietary_profile, :text) unless User.column_names.include?('encrypted_dietary_profile')
	add_column(:users, :encrypted_certificate_number, :text) unless User.column_names.include?('encrypted_certificate_number')
	add_column(:users, :encrypted_certificate_type, :text) unless User.column_names.include?('encrypted_certificate_type')
	add_column(:users, :encrypted_zipcode, :text) unless User.column_names.include?('encrypted_zipcode')

	change_column(:users, :adults, :integer, null: true)
	change_column(:users, :children, :integer, null: true)
	change_column(:users, :zipcode, :string, null: true)
  end
end
