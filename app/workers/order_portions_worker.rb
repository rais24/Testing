class OrderPortionsWorker
  include Sidekiq::Worker

  def perform(order_id, quantity = nil)
    order = Order.find(order_id)
    OrderPortion.transaction do
      order.portions.destroy_all
      order.recipes.each do |recipe|
        order.portions.add_recipe recipe, quantity: quantity
      end
    end
  # We DON'T want to retry missing records
  rescue ActiveRecord::RecordNotFound => ex
    puts ex.message
  end
end