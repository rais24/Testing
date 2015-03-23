module ZipcodesHelper
	def delivery_zone_for_zipcode(zipcode)
		return "N/A" if zipcode.delivery_zone.blank?
		zipcode.delivery_zone.name 
	end
end
