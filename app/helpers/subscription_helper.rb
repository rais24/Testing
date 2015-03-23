module SubscriptionHelper

  def insurance_providers
    insurance_provider_list = [["AET", "Aetna"], ["IBC", "Independence Blue Cross"], ["MDC", "Medicare"], ["UTD", "United"], ["CIG", "Cigna"], ["HOR", "Horizon"], ["BCBS", "Blue Cross Blue Shield"]]
    str=""
    insurance_provider_list.each do |ins_code, ins_name|
      if ins_code.blank?
        str << "<option selected='selected' value='#{ins_code}'>#{ins_name}</option>"
      else
        str << "<option value='#{ins_code}'>#{ins_name}</option>"
      end
    end
    str.html_safe
  end

  def is_user_selected_time_slot (signup_request, time_slot)
    return "checked" if time_slot == "7am-9am" && signup_request.time_slot.blank?
    return "" unless signup_request.time_slot == time_slot
    "checked"
  end

  def is_user_selected_delivery_day (signup_request, delivery_day)
    #binding.pry
    return "selected" if delivery_day == "Monday" && signup_request.delivery_day.blank?
    return "" unless signup_request.delivery_day == delivery_day
    "selected"
  end

  def delivery_day_selector signup_request
    str = "<select class=\"select required\" id=\"signup_request_delivery_day\" name=\"signup_request[delivery_day]\">"
    delivery_days.collect{ |x| x.first }.each do |x|
      str += "<option value=\"#{x}\" "
      str += is_user_selected_delivery_day(signup_request, x) + ">#{x}</option>"
    end
    str += "</select>"
    str.html_safe
  end

  def time_slot_selector signup_request
    str = "<div style=\"float:left; text-align:left;\">"
    delivery_time_slots.collect{ |x| x.first }.each_with_index do |x, n|
      str += "</div><div>" if n == 3
      str += "</div>" if n == 5
      str += "<input type=\"radio\" id=\"ex1_a\" name=\"signup_request[time_slot]\" value=\"#{x}\" "
      str += is_user_selected_time_slot(signup_request, x) + ">"
      str += "<label for=\"ex1_a\" style=\"margin-left:5px; margin-top:8px;\">#{x.upcase}</label>"
      str += "<br>"
    end
    str += "</div>"
    str.html_safe
  end

  def delivery_days
    [["Monday", "Monday"], ["Tuesday", "Tuesday"], ["Wednesday", "Wednesday"], ["Thursday", "Thursday"], ["Friday", "Friday"], ["Saturday", "Saturday"], ["Sunday", "Sunday"]]
  end

  def delivery_time_slots
    [["7am-9am","7am-9am"], ["9am-11am","9am-11am"],["11am-1pm","11am-1pm"], ["1pm-3pm","1pm-3pm"],["3pm-5pm","3pm-5pm"],["5pm-7pm","5pm-7pm"]]
  end

  def render_get_started_button plan_type
    get_started_text = ""
    if current_user
      get_started_text += link_to("Get Started", edit_account_path(page_type: "plan", plan: plan_type.to_i))
    else
      get_started_text += "<a href=\"/subscription?plan=#{plan_type.to_i}\">Get Started</a>" 
    end
    get_started_text.html_safe
  end

  def meal_plan_description subscription_type
    meal_plan_text = ""
    if subscription_type
      meal_plan_text += "<div class=\"dayplan\">"
      meal_plan_text += "<h1>#{subscription_type.to_i}</h1>day plan</div>"
      meal_plan_text += "<div class=\"includedplan\">"
      meal_plan_text += "<h3>What’s Included</h3>"
      meal_plan_text += "<ul><li>• Free consultation with a registered dietitian</li>"
      meal_plan_text += "<li>• 3 Meals (Breakfast, Lunch, Dinner, or any combo!)</li>"
      meal_plan_text += "<li>• 2 Snacks (Midday Snacks or Desserts!) </li>"
      meal_plan_text += "<li>• Meal Labels </li>" if subscription_type.to_i == 3 || subscription_type.to_i == 5
      meal_plan_text += "<li>• Starter Kit </li>" if subscription_type.to_i == 10 || subscription_type.to_i == 21
      meal_plan_text += "</ul></div>"
    end
    meal_plan_text.html_safe
  end

  def display_signup_greeting is_specialist
    return "<h2>Become a Fitly practitioner today!<h2>".html_safe if is_specialist
    "<h2>Discover how Fitly can help you reach your health goals!</h2>".html_safe
  end


  def subscription_type_tag user
    subscription_type_text = ""
    if user && user.subscription && user.subscription.subscription_type
      subscription_type_text += "<input type=\"hidden\" "
      subscription_type_text += "name=\"user[subscription_attributes][subscription_type]\" "
      subscription_type_text += "value=\"#{user.subscription.subscription_type}\" />"
    end
    subscription_type_text.html_safe
  end

  def dietitian_certifications
    [
      ['Registered Dietitian Nutritionist', 'RDN'],
      ['Registered Dietitian', 'RD']
    ]
  end

end