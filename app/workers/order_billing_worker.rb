class OrderBillingWorker
  include Sidekiq::Worker

  # Public: calls a (potentially long running) method on an OrderBilling
  #
  # :order_billing_id - Number the ID of the OrderBilling
  # :method           - Symbol the message to send to the OrderBilling instance
  #
  # NOTE: ActiveRecord::RecordNotFound exceptions will be ignored and not retried
  def perform(order_billing_id, method)
    OrderBilling.find(order_billing_id).send(method.to_sym)
  # We DON'T want to retry missing records
  rescue ActiveRecord::RecordNotFound => ex
    puts ex.message
  end
end