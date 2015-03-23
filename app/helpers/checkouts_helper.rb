module CheckoutsHelper
  def delivery_dates(zone)
    dates = []
    if zone.days.present?
    	zone.days.split(",").each do |day|
      		d = Chronic.parse("next #{day.strip}")
          unless d.day == 25 && d.month == 12
            if d < 7.day.from_now
              dates << [d.strftime('%A, %B %d'), d.strftime('%A, %B %d %Y'), d]
            end
          end
    	end
	  end
	  dates = dates.sort{|x,y| x[2] <=> y[2]}
	  dates.map{|a| a.slice(0,2)}
  end
end
