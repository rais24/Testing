module Admin
  class OrdersController < BaseController
    def index
      @orders = Order.all
    end
    
    def destroy
      @order = Order.find(params[:id])
      @order.destroy
      redirect_to admin_order_details_path
    end

    def resend_bpo
      @order = Order.find(params[:order_id])
      
      bpo_instruction = @order.generate_order_pdf
      # send email to user
      Mailer.bpo_instruction(@order, bpo_instruction, current_user.email).deliver
      
      redirect_to admin_order_details_path
    end

    def resend_confirmation
      @order = Order.find(params[:order_id])
      
      Mailer.order_confirmation(@order.id).deliver
      redirect_to details_admin_orders_path
    end
    
    def resend_recipes
      if ENV['SUPPORT_EMAIL']
        @order = Order.find(params[:order_id])
        recipe_instructions = @order.generate_recipe_instructions
        Mailer.recipe_instructions(@order, recipe_instructions, ENV['SUPPORT_EMAIL']).deliver if recipe_instructions
      end
      redirect_to details_admin_orders_path
    end
    
    def resend_missing
      @order = Order.find(params[:order_id])
      confirmation = @order.order_confirmations.last
      check = confirmation.order_check

      # all ingredients accounted for
      if check[:ingredients].empty? && check[:extras].empty?
        Mailer.bpo_send_correct(order, @order.bpo_processor.email).deliver
      else
        missing = check[:ingredients]
        extra = check[:extras]
        bpo_instruction = @order.generate_order_pdf
        Mailer.bpo_resend_instruction(@order, bpo_instruction, @order.bpo_processor.email, extra, missing).deliver
      end
      redirect_to details_admin_orders_path
    end
  end
end
