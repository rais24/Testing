module AccountsHelper

	def display_user_height selected_user
		return "N/A" if selected_user.height.blank?
		"#{selected_user.height_in_feet}\' #{selected_user.height_in_inches}\""
	end

	def display_user_gender selected_user
		return "N/A" if selected_user.gender.blank?
		return "Male" if selected_user.gender.downcase == "male"
		"Female"
	end

	def display_user_age_dob selected_user
		return "N/A" if selected_user.dob.blank?
		birth_date = Date.parse(selected_user.dob) 
		age = Date.today.year - birth_date.year
    age -= 1 if Date.today < birth_date + age.years
    "#{selected_user.dob} (#{age})"
	end

	def determine_tab_state selected_user, page_type, option_name
		case page_type
		when 'dietary_needs_list'
			return "dietary-needs-tabs" if selected_user.dietary_needs_list[option_name.to_sym]
		when 'dietary_preferences_list'
			return "dietary-needs-tabs" if selected_user.dietary_preferences_list[option_name.to_sym]
		end
		"dietary-needs-tabs dietary-needs-tabs-untick"
	end

	def display_user_greeting
		str = "<h1 class=\"h1-float-left\">"
		if @user != current_user
			str += "<br>#{@user.name}<br><br></h1>"
		else
			str += "Welcome, #{@user.name}"
	    str += ", #{current_user.certificate_type}." if @user.certificate_type    	
		end
    str += "</h1>"
    str += "<div class=\"profile-complete margintop\">"
    if @user.is_specialist? && @user.practitioner_code
    	str += "<span>Practitioner Code: #{@user.practitioner_code}</span></div>" 
    elsif @user.is_specialist? && @user.certificate_number
    	str += "<span>Practitioner Code: #{@user.certificate_number}</span></div>"
    end
    str += "</div>" 
    str.html_safe
  end

  def display_patient_meal_plan_status selected_user
  	str = ""
 		if selected_user.meal_plans.blank?
  		str += "<td class=\"secondcell\"><a href=\"#\">No Menu Items Selected</a>"   		
  	else
  		str += "<td class=\"secondcell2\"><div class=\"datatable-lastcell\"><a href=\"#\">Menu Items Selected</a>"
  		str += "<br/><a href=\"#\" style=\"color:#999; font-size:12px; font-style:italic;\">Pending Patient Review...</a>"
  		str += "</div>" 
  	end
  	str += "</td>"		
  	str.html_safe					
  end

  def display_patient_subscription selected_user
  	str = ""
  	if selected_user.subscription
  		str += "<td>#{selected_user.subscription.type}</td>"
			str += "<td>#{selected_user.subscription.created_at}></td>"
  	else
  		str += "<td>N/A</td>"
  		str += "<td>N/A</td>"
  	end
  	str.html_safe
  end

  def display_patient_actions selected_user
  	#str = "<div class=\"datatable-lastcell patient-actions\">"
  	str = "<div class=\"patient-actions\">"
  	if selected_user.meal_plans.blank?
  		str += link_to("Create Meal Plan", new_user_meal_plan_path(selected_user))
  		str += "<br />"
  		str += link_to("View Order History", user_orders_path(selected_user))
  	else
  		str += "<a href=\"#\">Send Review Reminder</a>" 		
  		str += "<br />"
  		str += link_to("Edit Meal Plan", edit_user_meal_plan_path(selected_user))
		end
		str += "</div>"
		str.html_safe
  end

end