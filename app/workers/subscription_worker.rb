class SubscriptionWorker
  include Sidekiq::Worker

  def perform(order_billing_id, method)
    # Create Order
    # Create billing and associate it with order
  # We DON'T want to retry missing records
  rescue ActiveRecord::RecordNotFound => ex
    puts ex.message
  end
end



