class UpdateDeliveryZoneDays < ActiveRecord::Migration
	class DeliveryZone < ActiveRecord::Base
	  def valid_days
	    if name == "1"
	      ["Tuesday", "Thursday", "Sunday"]
	    elsif name == "2"
	      ["Tuesday", "Thursday", "Sunday"]
	    elsif name == "3"
	      ["Monday", "Wednesday", "Friday"]
	    elsif name == "4"
	      ["Wednesday", "Saturday"]
	    elsif name == "5"
	      ["Monday", "Friday", "Saturday"]
	    end
	  end
  end
  
  def change
  	DeliveryZone.all.each do |delivery_zone|
  		delivery_zone.days = delivery_zone.valid_days.join(", ")
  		delivery_zone.save
  	end
  end
end
