module OrdersHelper
  def order_servings
    @servings||= Recipe.published.order('id desc').limit(order_columns).map do |recipe|
      @order.servings.find_or_initialize_by recipe_id: recipe.id
    end
  end

  def order_columns
    if current_user.billing
      6
    else
      8
    end
  end

  def display_telephone(phone)
    "(#{phone[0..2]}) #{phone[3..5]}-#{phone[6..-1]}"
  end

  def checkout_button_text(order)
    if order.checked_out?
      "Edit Order"
    else
      "Checkout"
    end
  end

  def serving_override(quantity, from: {})
    from_params = params.merge(from)
    if from_params[:servings]
      from_params[:servings].to_i
    else
      quantity.to_i
    end
  end
  
  def show_serving_in_cart(order_serving)
    link_to order_serving.name.titleize + ' ' + number_to_currency(order_serving.total_price), order_serving.recipe, class: 'cart-item-name'
  end

  def display_customer_details(order)
    return "n/a" if order.user.blank?
    user_address = order.user.address.blank? ? order.user.address : order.address
    customer_detail = ""
    customer_detail << "<strong>#{order.user_name}</strong> (#{order.user.email})<br />".html_safe
    customer_detail << "Phone: #{user_address.phone}<br />".html_safe unless user_address.blank?
    customer_detail << "#{user_address.street}<br />".html_safe unless user_address.blank?
    customer_detail << "#{user_address.city}, #{user_address.state} #{user_address.zipcode}".html_safe unless user_address.blank?
    return customer_detail.html_safe
  end

  def display_recipes(servings)
    return "" if servings.empty?
    recipe_names = "<ol>"
    servings.each_with_index {|s, i| recipe_names << "<li>#{i+1}. #{s.recipe.name}&nbsp;(#{s.quantity})</li>" }
    recipe_names << "<ol>"
    recipe_names.html_safe
  end

  def display_promo(used_promo)
    return "" if used_promo.blank?
    return "#{number_to_currency(used_promo.discount)}<br />#{used_promo.code}".html_safe if used_promo.discount && !used_promo.discount.zero?
    "#{used_promo.discount_percent}%<br />#{used_promo.code}".html_safe
  end

  def display_total_adjusted_subtotal(order)
    return number_to_currency(order.subtotal) if order.used_promo.blank?
    if order.used_promo.discount && !order.used_promo.discount.zero?
      total_price = number_to_currency(order.price + order.used_promo.discount)
    elsif order.used_promo.discount_percent && !order.used_promo.discount_percent.zero?
      total_price = number_to_currency(order.price * (100.0/(100.0 - order.used_promo.discount_percent)))
    end      
  end

  def display_order_processing_details(order)
    order_details = "<strong>Processor:</strong> #{order.bpo_processor.email}<br />".html_safe if order.bpo_processor
    order_details ||= ""
    order_details << display_delivery(order.delivery_time).html_safe
  end

  def display_delivery(delivery_time)
    return "" if delivery_time.blank?
    delivery_date_verbose = delivery_time.delivery_date.strftime("%d %b %y") 
    delivery_info = ""
    delivery_info << "Date: #{delivery_date_verbose}, Time: #{delivery_time.time_slot}".html_safe 
  end

  def display_order_date(order)
    o_date = order.created_at.strftime("%d %b %y")
    o_time = order.created_at.strftime("%H:%M")
    "#{o_date}<br/>#{o_time}".html_safe
  end

  def display_actions_list(order)
    links = link_to( "1. Check whole order", check_order_path(order)).html_safe << "<br/> ".html_safe
    links << link_to( "2. Delete order", admin_order_path(order), method: :delete, data: {confirm: "Are you sure you want to delete order: #{order.id}?"}).html_safe << "<br/>".html_safe 
    if order.checked_out?
      links << link_to( "3. Reprint pdf", pdf_order_path(order), format: :pdf).html_safe << "<br/>".html_safe 
      links << link_to( "4. Resend recipes", admin_order_resend_recipes_path(order), format: :pdf).html_safe << "<br/>".html_safe 
      links << link_to( "5. Resend bpo email", admin_order_resend_bpo_path(order)).html_safe << "<br />".html_safe
      links << link_to( "6. Resend bpo missing email", admin_order_resend_missing_path(order)).html_safe << "<br />".html_safe
      links << link_to( "7. Resend confirmation email", admin_order_resend_confirmation_path(order))
    end
    links
  end
end
