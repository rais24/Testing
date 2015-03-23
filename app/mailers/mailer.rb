class Mailer < ActionMailer::Base
  helper MailHelper

  FROM = "The Fitly Family <contact@fitly.org>"
  ORDERS = "orders@fitly.org"
  NOTIFICATIONS = "fawad@fitly.com"

  default from: FROM

  def order_confirmation(order_id)
    @order = Order.find(order_id)

    if @order.deliverable?
      mail to: @order.user.email, subject: "Your Fitly.com Order"
    end
  rescue ActiveRecord::RecordNotFound
  end

  def order_confirmation_with_recipes(order_id, recipe_instructions)
    @order = Order.find(order_id)
    attachments["#{order_id}_recipes.pdf"] = { :mime_type => 'application/pdf', :content => recipe_instructions.render }

    if @order.deliverable?
      mail to: @order.user.email, subject: "Your Fitly.com Order"
    end
  rescue ActiveRecord::RecordNotFound
  end

  def admin_order_confirmation(order_id)
    @order = Order.find(order_id)

    if @order.deliverable?
      mail to: ORDERS, subject: @order.report_name
    end
  rescue ActiveRecord::RecordNotFound
  end

  def recipe_instructions(order, recipe_instructions, send_to)
    destination = send_to
    attachments["#{order.id}_recipes.pdf"] = { :mime_type => 'application/pdf', :content => recipe_instructions.render }

    @order = order

    mail to: destination, subject: "Recipes for Order - #{order.id}", :body => "", bcc: NOTIFICATIONS
  end

  def bpo_instruction(order, bpo_instruction, send_to)
    destination = send_to
    attachments["#{order.id}_ingredients.pdf"] = { :mime_type => 'application/pdf', :content => bpo_instruction.render }

    @order = order

    mail to: destination, subject: "New Order To Be Processed - Order #{order.id}"
  end
  
  def bpo_send_correct(order, send_to)
    @order = order
    mail to: send_to, subject: "Order successful! - Order #{order.id}"
  end
  
  def bpo_resend_instruction(order, bpo_instruction, send_to, extra_ingredients = [], missing_ingredients = [])
    attachments["#{order.id}_ingredients.pdf"] = { :mime_type => 'application/pdf', :content => bpo_instruction.render }
    @order = order
    @missing = missing_ingredients
    @extras = extra_ingredients
    mail to: send_to, subject: "ORDER ERROR - Fitly Order ID #{order.id} - FIX IMMEDIATELY"
  end

  def checkout_failure(order, error_details)
    @order = order
    @error_details = error_details
    recipient = Rails.env.development? ? "fawad@fitly.com" : NOTIFICATIONS
    mail to: recipient, subject: "ORDER CHECKOUT FAILED - Fitly Order ID #{order.id}"
  end

end
