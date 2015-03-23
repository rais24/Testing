class Checkout < Struct.new(:url_helpers, :order, :notifier)

  def finish_checkout_path(user)
    if user.guest?
      url_helpers.new_user_path
    elsif user.billing.blank?
      url_helpers.new_billing_path
    else
      url_helpers.order_path(order)
    end
  end

  def checkout
    if order.deliverable? && !order.checked_out?
      order.update! checked_out: true
      if notifier.present?
        notifier.notify(order)
      end
    end
  end
end