class AssignStoresToZipcodes < ActiveRecord::Migration
  def change
  	# Assign zip code to Fairless hills zipcode
  	store_fairless = Store.where("name like ?", "%Fairless%").first
  	unless store_fairless.nil?
	  	Zipcode.all.each_with_index do |zipcode|
	  		StoreZipcode.create(store: store_fairless, zipcode: zipcode)
	  	end
  	end
  end
end
