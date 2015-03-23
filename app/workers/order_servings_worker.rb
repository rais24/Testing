class OrderServingsWorker
  include Sidekiq::Worker

  def perform(order_id, quantity)
    order = Order.find(order_id)
    OrderServing.transaction do
      order.servings.find_each do |serving|
        serving.update quantity: quantity
      end
    end
  # We DON'T want to retry missing records
  rescue ActiveRecord::RecordNotFound => ex
    puts ex.message
  end
end