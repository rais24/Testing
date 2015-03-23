module Orders
  class Notifier
    def notify(order)
      if order.present?
        #MailerWorker.perform_async(:order_confirmation, order.id)
        #MailerWorker.perform_async(:admin_order_confirmation, order.id)
        Mailer.order_confirmation(order.id).deliver
        #Mailer.admin_order_confirmation order.id
      end
    end
  end
end
