class OrderRecipesPrintWorker
  include Sidekiq::Worker

  def perform(order_id)

      order = Order.find(order_id)
      if order 
        recipe_instructions = order.generate_recipe_instructions
        if recipe_instructions
          if order.bpo_processor && order.bpo_processor.remote_printer_email
            Mailer.recipe_instructions(order, recipe_instructions, order.bpo_processor.remote_printer_email).deliver
          else
            puts "Failed to send recipe instructions to printer - No BPO processor assigned to order #{order_id}."
          end
        else
          puts "Failed to send recipe instructions to printer - No recipes generated for order #{order_id}."
        end
      else
        puts "Failed to send recipe instructions to printer - Order #{order_id} does not exist."
      end
  # We DON'T want to retry missing records
  rescue ActiveRecord::RecordNotFound => ex
    puts ex.message
  end
end