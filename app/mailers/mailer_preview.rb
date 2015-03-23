class MailerPreview < MailView
  def order_confirmation
    Mailer.order_confirmation(Order.ids.first)
  end

  def admin_order_confirmation
    Mailer.admin_order_confirmation(Order.ids.first)
  end
end