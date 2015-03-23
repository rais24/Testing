class OrderWorker
	#include Sidekiq::Worker

	def perform(order_id, quantity = nil)
    order = Order.find(order_id)
    #quantity ||= order.user_family_size
		Rails.logger.warn "-----------------------------"
		Rails.logger.warn "updating order with #{quantity}"
  	update_portions order.portions, order.recipes, quantity
  	update_servings order.servings, quantity
  # We DON'T want to retry missing records
  rescue ActiveRecord::RecordNotFound => ex
    puts ex.message
	end

	private
		def update_servings(servings, quantity)
      OrderServing.transaction do
  			servings.find_each do |serving|
        	serving.update quantity: quantity
      	end
      end
		end

		def update_portions(portions, recipes, quantity)
      OrderPortion.transaction do
  	    portions.destroy_all
  	    recipes.each do |recipe|
  	      portions.add_recipe recipe, quantity: quantity
  	    end
      end
		end
end
