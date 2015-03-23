class ShoppingCartsController < ApplicationController
  skip_before_filter :authenticate
  before_filter :store_current_location

  def show
    if current_user.is? :admin
      @order = Order.find_or_create_by shopping_cart_id: cart.id, user_id: current_user.id
      # transfer the cart to the order
      @order.merge_with_cart
      @order.reload

      @order.portions.groceries.each do |portion|
        unless portion.include?
          si = portion.ingredient.products.first
          unless si.blank?
            amt_needed = (portion.quantity / si.amount).ceil
            @order.order_products.create(price: si.price, quantity: amt_needed, product_id: si.id)
          end
        end
      end
    end
  end

  private 

  def store_current_location
    unless logged_in?
      session[:return_to] = shopping_cart_path
      redirect_if_not login_url
    end
  end

end
