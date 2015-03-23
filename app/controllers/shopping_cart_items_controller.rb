class ShoppingCartItemsController < ApplicationController
  skip_load_and_authorize_resource
  skip_before_filter :authenticate

  def create
    recipe = Recipe.find(params[:shopping_cart_item][:recipe_id])
    cart.add(recipe, params[:shopping_cart_item][:price], params[:shopping_cart_item][:quantity].to_i)

    Pricing.update(cart)

    respond_to do |format|
      format.html { redirect_to shopping_cart_path }
    end
  end

  def update
    item = cart.shopping_cart_items.find params[:id]
    item.update! quantity: params[:shopping_cart_item][:quantity].to_i

    Pricing.update(cart)

    respond_to do |format|
      format.html { redirect_to shopping_cart_path }
    end
  end

  def destroy
    item = cart.shopping_cart_items.find params[:id]
    item.destroy

    Pricing.update(cart)

    respond_to do |format|
      format.html { redirect_to shopping_cart_path }
    end
  end

end
