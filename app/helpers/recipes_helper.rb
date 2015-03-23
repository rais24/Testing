module RecipesHelper
  def cart_action(recipe)
    render cart_action_partial(recipe), order: next_order, serving: serving(resource)
  end

  def cart_action_partial(recipe)
    if serving(recipe).empty?
      'order_servings/add'
    else
      'order_servings/remove'
    end
  end

  def recipe_columns(recipes)
    [3, 4, 6].select { |mod| recipes.count % mod == 0 }.last || 4
  end

  def ingredients(recipe)
    Ingredient.where('id NOT IN (?)', recipe.ingredients.pluck(:id))
  end

  def cart_link_to(order, recipe)
    serving = order.servings.find_or_initialize_by recipe_id: recipe.id

    partial = if serving.persisted?
                "remove"
              else
                "add"
              end

    render "order_servings/#{partial}", order: order, serving: serving
  end

  def serving(recipe)
    @serving ||= next_order.servings.find_or_initialize_by recipe_id: recipe.id
  end

  def sort_ingredients
    Ingredient.all.sort { |p1, p2| p1.name <=> p2.name }
  end

  def show_serving_price(cart)
    max_price_per_serving = Pricing.max_price_per_serving
    html = number_to_currency(max_price_per_serving)
    if cart.current_price_per_serving < max_price_per_serving
      html = "<strike>#{number_to_currency(max_price_per_serving)}</strike>"
      html << "<br/>"
      html << number_to_currency(cart.price_per_serving)
    end
    html
  end
  
  def show_ingredient_string(ingredient)
    str = "#{ingredient.to_display_amount(4)} #{ingredient.name}"
    str << ", #{ingredient.additional_instructions}" unless ingredient.additional_instructions.blank?
    str
  end

  def formatted_price(price, quantity) 
    sprintf('%.2f', price * quantity.to_f)
  end

  def show_total_cart_price cart
    return number_to_currency(0) if cart.nil? || cart.current_price_per_serving.nil?
    number_to_currency( cart.current_price_per_serving * 4 )
  end

  def serving_quantities(default_selection=4)
    str=""
    Pricing.serving_options_with_price.each do |qty, price|
      if qty.to_i == default_selection
        str << "<option selected='selected' value='#{qty}' data='#{formatted_price(price, qty)}'>#{qty} = $#{price} each</option>"
      else
        str << "<option value='#{qty}' data='#{formatted_price(price, qty)}'>#{qty} = $#{price} each</option>"
      end
    end
    str.html_safe
  end
end
