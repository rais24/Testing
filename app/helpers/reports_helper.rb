module ReportsHelper

	def display_month_year_date month_date
		"#{month_date.strftime("%b %y")}"
	end

	def display_default_growth_val data_value
		return "-" if data_value.blank?
		number_to_percentage(data_value, precision: 1) 
	end

	def display_monthly_user_report_row (month_date, data)
		row_data = "<td>" + display_month_year_date(month_date) + "</td>"
		row_data += "<td>" + data[:registrations].to_s + "</td>"
		row_data += "<td>" + display_default_growth_val(data[:registrations_growth]) + "</td>"		
		row_data += "<td>" + data[:customers].to_s + "</td>"
		row_data += "<td>" + display_default_growth_val(data[:customers_growth]) + "</td>"		
		row_data += "<td>" + data[:repeat_customers].to_s + "</td>"
		row_data += "<td>" + display_default_growth_val(data[:repeat_customers_growth]) + "</td>"		
		row_data += "<td>" + data[:orders].to_s + "</td>"
		row_data += "<td>" + display_default_growth_val(data[:orders_growth]) + "</td>"		
		row_data += "<td>" + number_to_currency(data[:subtotal]).to_s + "</td>"		
		row_data += "<td>" + display_default_growth_val(data[:subtotal_growth]) + "</td>"		
		row_data += "<td>" + number_to_currency(data[:promos]).to_s + "</td>"		
		row_data += "<td>" + display_default_growth_val(data[:promos_growth]) + "</td>"		
		row_data += "<td>" + number_to_currency(data[:total]).to_s+ "</td>"		
		row_data += "<td>" + display_default_growth_val(data[:total_growth]) + "</td>"
		row_data.html_safe
	end

	def display_monthly_user_report_totals
		row_data = "<td/><br /><b>TOTAL</b><td><br />#{@total_registrants}</td><td/>"
		row_data += "<td><br />#{@total_customers}</td><td/>"
		row_data += "<td><br />#{@total_repeat_customers}</td><td/>"
		row_data += "<td><br />#{@total_orders}</td><td/>"
		row_data += "<td><br />#{number_to_currency(@total_revenue).to_s}</td><td/>"
		row_data += "<td><br />#{number_to_currency(@total_promos).to_s}</td><td/>"
		row_data += "<td><br />#{number_to_currency(@total_revenue_after_promos).to_s}</td><td/>"
		row_data.html_safe
	end

end