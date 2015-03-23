module ShoppingCartsHelper
  def cart_button_text(_cart)
    if _cart.total_unique_items < 20
      'Keep Shopping<br><span class="exit">Add more servings and save up to $40!</span>'.html_safe
    else
      'Keep Shopping'
    end
  end

  def add_more_text(_cart)
    case _cart.total_unique_items
    when 0..11
      "If you add <strong>#{12 - _cart.total_unique_items} more servings of any recipe</strong>, your price per serving drops to $6.99, <strong>saving you $12.00 total</strong>.".html_safe
    when 12..19
      "If you add <strong>#{20 - _cart.total_unique_items} more servings of any recipe</strong>, your price per serving drops to $5.99, <strong>saving you $40.00 total</strong>.".html_safe
    else
      "<strong>Awesome!</strong> By ordering at least 20 servings, <strong>you're saving $40.00</strong> on this order.".html_safe
    end
  end

  def display_price_per_serving(servings)
    return "" unless servings
    price_per_serving = Pricing.price_per_serving(servings) 
    return "" unless price_per_serving
    number_to_currency( price_per_serving )
  end

  def display_item_total(servings)
    return "" unless servings
    price_per_serving = Pricing.price_per_serving(servings) 
    return "" unless price_per_serving
    number_to_currency(price_per_serving * servings)
  end
end
