class DeliveryZonesController < InheritedResources::Base
  load_resource
  skip_authorize_resource

  def available_time_slots
  	@time_slots = params[:selected_day].present? ? restricted_slots : @delivery_zone.valid_times
    selected_day = Chronic.parse(params[:selected_day])
    remove_immediate_slots(selected_day)
    remove_holidays(selected_day)
  	respond_to do |format|
    	format.json { render json: @time_slots, root: "data" }
    end
  end

  private 

  def restricted_slots
  	if @delivery_zone.restricted_times.present?
			slot_restrictions = YAML.load(@delivery_zone.restricted_times)
			return slot_restrictions[params[:selected_day].to_sym] if slot_restrictions && slot_restrictions.include?(params[:selected_day].to_sym)
			@delivery_zone.valid_times 
	  else
	  	@delivery_zone.valid_times  	
  	end
  end

  def remove_immediate_slots selected_day
    # can't deliver same day before 3 pm if order is being placed after 9 am
    # can't deliver next day before 3 pm if order is being placed after 3 pm
    if ((Time.now > Time.parse("01:00:00") && selected_day == Chronic.parse("today")) || (Time.now > Time.parse("15:00:00") && selected_day == Chronic.parse("tomorrow")))
      ["7am-9am", "9am-11am", "11am-1pm", "1pm-3pm"].each { |x| @time_slots.delete(x) }
    end
  end
  
  def remove_holidays selected_day
    # can't deliver after 3pm on Dec 24
    # can't deliver on Dec 25
    if selected_day.month == 12
      case selected_day.day
      when 24
        ["3pm-5pm", "5pm-7pm", "7pm-9pm"].each { |x| @time_slots.delete(x) }
      when 25
        @time_slots.clear
      when 31
        ["5pm-7pm", "7pm-9pm"].each { |x| @time_slots.delete(x) }
      end
    elsif selected_day.month == 1 && selected_day.day == 1
      ["7am-9am", "5pm-7pm", "7pm-9pm"].each { |x| @time_slots.delete(x) }
    end
  end
end
