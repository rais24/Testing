module DeliveryZonesHelper
  def zipcode_list(zone)
  	return "N/A" if zone.zipcodes.blank?
  	zone.zipcodes.order(:code).map(&:code).join(",")
  end

  def stores_list(zone)
    return "N/A" if zone.zipcodes.blank?
    zone.zipcodes.map(&:stores).flatten.uniq.map(&:name).join(", ")
  end

  def valid_days_list(zone)
  	valid_delivery_days = zone.days.presence || zone.valid_days
  	return "N/A" if valid_delivery_days.blank?
  	return valid_delivery_days if valid_delivery_days.is_a?(String)
  	valid_delivery_days.join(",")
  end
end
