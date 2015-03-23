class CheckoutsController < ApplicationController
  include Wicked::Wizard

  skip_load_and_authorize_resource

  before_filter :can_checkout?

  steps :signup, :pantry, :delivery_address, :delivery_time, :payment, :review, :confirmation

  def show
    case step
    when :signup
      if current_user.guest
        @user = current_user
      else
        skip_step
      end
    when :delivery_address
      @order = Order.find_or_create_by user_id: current_user.id, shopping_cart_id: cart.id
      @user = current_user
    when :delivery_time
      @order = Order.find_or_create_by user_id: current_user.id, shopping_cart_id: cart.id
      if current_user.user_group.present? && current_user.user_group.delivery_zone.present?
        @zone = current_user.user_group.delivery_zone
      else
        zip = Zipcode.find_by code: @order.address.zipcode
        @zone = zip.delivery_zone
      end
    when :pantry
      @order = Order.find_or_create_by shopping_cart_id: cart.id, user_id: current_user.id
      # transfer the cart to the order
      @order.merge_with_cart
      @order.reload
      @pantry_items = []
      # build the pantry item list
      @order.portions.groceries.each do |portion|
        unless portion.include?
          si = portion.ingredient.products.first
          unless si.blank?
            @pantry_items << {name: si.name, price: si.price, id: portion.id}
          end
        end
      end
      # build the cash back item list
      @cash_back_items = []
      @order.portions.cash_back.each do |portion|
        si = portion.ingredient.products.first
        unless si.blank?
          @cash_back_items << {name: si.name, price: si.price, id: portion.id}
        end
      end            
    when :payment
      @order = Order.find_by shopping_cart_id: cart.id, user_id: current_user.id
      @user = current_user
    when :review
      @order = Order.find_by shopping_cart_id: cart.id, user_id: current_user.id

    when :confirmation
      @user = current_user
      @order = Order.find_by shopping_cart_id: cart.id, user_id: current_user.id

      session.delete(:shopping_cart_id)
    end

    if step == Wicked::FINISH_STEP
      checkout.checkout
    end
    render_wizard
  end

  def update
    case step
    when :signup
      @user = current_user
      signup_params = params.require(:user).permit(:email,:first,:last,:zipcode,:password,:password_confirmation,:guest,:invite_code,:ok_to_email)
      @user.update_attributes(signup_params)
      resolve_user_group(signup_params)
      apply_promo_code(signup_params)

     # no longer a guest
      render_wizard @user and return
    when :pantry
      @user = current_user
      @order = @user.orders.find_by shopping_cart_id: cart.id

      if params[:pantry_ingredient_ids]
        received_pantry_ingredient_ids = params[:pantry_ingredient_ids].split(",") 
        received_pantry_ingredient_ids.each do |i|
          portion = @order.portions.groceries.find i
          si = portion.ingredient.products.first
          unless si.blank?
            amt_needed = (portion.quantity / si.amount).ceil
            @order.order_products.create(price: si.price, quantity: amt_needed, product_id: si.id, pantry: true, cashback: false)
          end
        end
      end

      @order.order_cashback_items.clear
      if params[:cashback_ingredient_ids]
        received_cashback_ingredient_ids = params[:cashback_ingredient_ids].split(",") 
        received_cashback_ingredient_ids.each do |i|
          portion = @order.portions.cash_back.find i
          si = portion.ingredient.products.first
          unless si.blank?
            amt_needed = (portion.quantity / si.amount).ceil
            @order.order_cashback_items.create(price: si.price, quantity: amt_needed, product_id: si.id, pantry: true, cashback: true)
          end
        end
      end

      render_wizard @order and return
    when :delivery_address
      @user = current_user
      @order = @user.orders.find_by shopping_cart_id: cart.id

      # "saved_address"=>"use_saved_address"
      if params[:saved_address] && params[:saved_address] == "use_saved_address"
        @order.build_address @user.address.attributes.reject{|k,v| k=='id'}
        # if @user.zipcode != @user.address.zipcode
        #   flash.now[:alert] = "Delivery must be sent to the same zipcode that you signed up with."
        #   render_wizard and return
        # end
        unless Zipcode.can_service_zipcode?(@order.address.zipcode).blank?
           flash.now[:alert] = "Bummer! Looks like we're not delivering in your area. However, Fitly is expanding rapidly and may start delivering to your zipcode. You will receive an email from us when we start delivering to your area."
           render_wizard and return
        end
      else
        @address = Address.new(params.require(:order).require(:address).permit(:street1, :street2, :city, :state, :zipcode, :phone, :first_name, :last_name))
        # if @user.zipcode != @address.zipcode
        #   flash.now[:alert] = "Delivery must be sent to the same zipcode that you signed up with."
        #   render_wizard and return
        # end
        @order.build_address @address.attributes if @address.valid?
        unless Zipcode.can_service_zipcode?(@order.address.zipcode).blank?
           flash.now[:alert] = "Bummer! Looks like we're not delivering in your area. However, Fitly is expanding rapidly and may start delivering to your zipcode. You will receive an email from us when we start delivering to your area."
           render_wizard and return
        end
        @user.build_address @address.attributes if @address.valid?
        unless @address.save && @order.save && @user.save
          render_wizard and return
        end
      end

      render_wizard @order and return
    when :delivery_time
      @user = current_user
      @order = @user.orders.find_by shopping_cart_id: cart.id
      zip = Zipcode.find_by code: @order.address.zipcode
      @zone = zip.delivery_zone
      
      @delivery_time = @order.build_delivery_time(params.require(:order).require(:delivery_time).permit(:time_slot, :delivery_date).merge(delivery_zone_id: @zone.id))
      @order.comments = params[:order][:comments]

      unless @order.save && @delivery_time.save
        render_wizard and return
      else
        render_wizard @order and return
      end
    when :payment
      @order = current_user.orders.find_by shopping_cart_id: cart.id

      unless params[:saved_card] && params[:saved_card] == "use_saved_card"
        # Get the credit card details submitted by the form
        token = params[:stripeToken]

        # Create a Customer
        customer = Stripe::Customer.create(
          card: token,
          email: current_user.email,
          description: current_user.name
        )

        if current_user.billing
          b = current_user.billing
        else
          b = Billing.new(user: current_user)
        end

        Billing.merge!(customer: customer, billing: b)
      end

      render_wizard @order and return

    when :review
      @order = current_user.orders.find_by shopping_cart_id: cart.id
      begin
        if @order.used_promo && @order.used_promo.promo && @order.used_promo.code.downcase == "test"
          @order.confirm_test! current_user          
        else
          @order.confirm! current_user
        end
        render_wizard @order and return
      rescue StandardError => se
        flash.now[:alert] = "Oh no! We unfortunately encountered a technical error that prevented us from processing your order. Our team is on it, and will be getting back to you shortly. We apologize for the inconvenience."
      end      

    end
    render_wizard
  end

  def finish_wizard_path
    checkout.finish_checkout_path(current_user)
  end

  protected

    def apply_promo_code signup_params
      invite_code = signup_params[:invite_code]
      promo = Promo.find_by_code(invite_code)
      cart.add_promo(promo) if promo
    end

    def resolve_user_group signup_params
      invite_code = signup_params[:invite_code]
      user_group = UserGroup.find_by_code(invite_code)
      if user_group
        @user.user_group = user_group 
        @user.save!
      end
    end

    def display_cart?
      false
    end

    def can_checkout?
      unless cart.can_checkout?
        flash.now[:alert] = "You must select at least 8 servings to checkout."
        redirect_to recipes_path and return
      end
      if current_user.guest?
        flash.now[:alert] = "You must signup for an account to checkout."
        session[:return_to] = wizard_path(:pantry)
        jump_to(:signup) unless step == :signup
      end
    end

end
