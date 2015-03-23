module RecipePortionsHelper
  def sort_portions(recipe_id)
    Recipe.find(recipe_id).portions.sort_by{ |x| x.order.blank? ? x.quantity : x.order}
  end
end
