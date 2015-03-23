class DeliveryPortionsWorker
  include Sidekiq::Worker

  def perform(delivery_id)
    delivery = Delivery.find(delivery_id)
    delivery.portions.delete_all
    delivery.orders.each do |order|
      delivery.portions.add_order(order)
    end
  # We DON'T want to retry missing records
  rescue ActiveRecord::RecordNotFound => ex
    puts ex.message
  end
end