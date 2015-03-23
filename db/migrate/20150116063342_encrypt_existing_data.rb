class EncryptExistingData < ActiveRecord::Migration
  def change
  	encrypt_users_data
  	encrypt_addresses_data
  	encrypt_billing_data
  end

  def encrypt_users_data
  	User.all.each do |u|
		 	u.first = u[:first]		  
		 	u.last = u[:last]
		  u.adults = u[:adults]
		  u.children = u[:children]
		  u.weight = u[:weight]
		  u.height = u[:height]
		  u.practitioner_code = u[:practitioner_code]
		  u.invite_code = u[:invite_code]
		  u.dob = u[:dob]
		  u.gender = u[:gender]
		  u.dietary_profile = u[:dietary_profile]
		  u.certificate_number = u[:certificate_number]
		  u.certificate_type = u[:certificate_type]
		  u.zipcode = u[:zipcode]
		 				  
	  	u[:first] = nil
	  	u[:last] = nil
	  	u[:adults] = nil
	  	u[:children] = nil
	  	u[:weight] = nil
	  	u[:height] = nil
	  	u[:practitioner_code] = nil
	  	u[:invite_code] = nil
	  	u[:dob] = nil
	  	u[:gender] = nil
	  	u[:dietary_profile] = nil
	  	u[:certificate_number] = nil
	  	u[:certificate_type] = nil
	  	u[:zipcode] = nil

		  u.save!
		end
  end

  def encrypt_addresses_data
  	Address.all.each do |u|
		 	u.street1 = u[:street1]		  
		 	u.street2 = u[:street2]
		  u.city = u[:city]
		  u.state = u[:state]
		  u.zipcode = u[:zipcode]
		  u.first_name = u[:first_name]
		  u.last_name = u[:last_name]
		 				  
	  	u[:street1] = nil
	  	u[:street2] = nil
	  	u[:city] = nil
	  	u[:state] = nil
	  	u[:zipcode] = nil
	  	u[:first_name] = nil
	  	u[:last_name] = nil

		  u.save!
		end
  end

  def encrypt_billing_data
  	Billing.all.each do |u|
		 	u.expiration_month = u[:expiration_month]		  
		 	u.expiration_year = u[:expiration_year]
		  u.last_4 = u[:last_4]
		  u.name = u[:name]
		  u.card_type = u[:card_type]
		 				  
	  	u[:expiration_month] = nil
	  	u[:expiration_year] = nil
	  	u[:last_4] = nil
	  	u[:name] = nil
	  	u[:card_type] = nil

		  u.save!
		end
  end

end