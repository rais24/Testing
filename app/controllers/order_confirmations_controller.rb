class OrderConfirmationsController < ApplicationController
  skip_load_and_authorize_resource
  skip_before_filter :authenticate
  
  
  def create
    confirmation = OrderConfirmation.create(
                              supplier: "Shoprite",
                              raw_message: params["body-html"],
                              send_date: Time.at(params["timestamp"].to_i).to_datetime,
                              recipient: params["recipient"]
                            )
                            
    begin
      check = confirmation.order_check
      order = confirmation.order
      # all ingredients accounted for
      if check[:ingredients].empty? && check[:extras].empty?
        Mailer.bpo_send_correct(order, order.bpo_processor.email).deliver
      else
        missing = check[:ingredients]
        extra = check[:extras]
        bpo_instruction = order.generate_order_pdf
        Mailer.bpo_resend_instruction(order, bpo_instruction, order.bpo_processor.email, extra, missing).deliver
      end      
    rescue
    end
    respond_to do |format|
      format.any(:html, :json) {render status: 200, nothing: true}
    end
  end
end
