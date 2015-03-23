class IngredientsController < InheritedResources::Base
  #include SluggedResource

  def update
    @ingredient.products << Product.find(permitted_params[:ingredient][:product_ids].split(",")) if permitted_params[:ingredient][:product_ids]    
    @ingredient.update permitted_params[:ingredient].except(:product_ids)
    redirect_to @ingredient
  end

  def destroy
    destroy! { ingredients_path }
  end

  def permitted_params
    params.permit ingredient: [:name, :unit, :pantry, :category, :photo, :measurement_type, :cash_back, :product_ids]
  end

  protected
    helper_method :recipes
    def recipes
      RecipePortion.where(ingredient_id: @ingredient.id)
    end
end
