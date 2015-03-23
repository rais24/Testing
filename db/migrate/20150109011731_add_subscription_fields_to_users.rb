class AddSubscriptionFieldsToUsers < ActiveRecord::Migration
  def change
 		User.reset_column_information
	 	unless User.column_names.include?('weight')
			add_column :users, :weight, :decimal, precision: 5, scale: 2
	 	end
	 	unless User.column_names.include?('height')
			add_column :users, :height, :decimal, precision: 2, scale: 1
	 	end
	 	add_column(:users, :practitioner_code, :string) unless User.column_names.include?('practitioner_code')
	 	add_column(:users, :dob, :date) unless User.column_names.include?('dob')
	 	add_column(:users, :gender, :string) unless User.column_names.include?('gender')
	 	add_column(:users, :dietary_profile, :text) unless User.column_names.include?('dietary_profile')
	 	add_column(:users, :certificate_number, :string) unless User.column_names.include?('certificate_number')
	 	add_column(:users, :certificate_type, :string) unless User.column_names.include?('certificate_type')
  end
end
