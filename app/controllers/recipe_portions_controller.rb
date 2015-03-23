class RecipePortionsController < InheritedResources::Base
  defaults collection_name: :portions
  belongs_to :recipe, finder: :find_by_id_or_slug!, polymorphic: true

  def create
    update_portion(parent.portions, params[:portion])
    create!
  end

  def edit
    @recipe = Recipe.find_by(slug: params[:recipe_id])
    @portion = RecipePortion.find(params[:id])
  end

  def update
    @portion = RecipePortion.find(params[:id])
    portion_order = params[:recipe_portion][:order]
    if (portion_order.blank? || portion_order == "")
      portion_order = (RecipePortion.where(recipe: @portion.recipe).maximum(:order) + 1) || 1
    end
    RecipePortion.update_all({quantity: params[:recipe_portion][:quantity], order: portion_order, include: params[:recipe_portion][:include]}, {id: @portion.id})
    redirect_to recipe_recipe_portions_path, alert: "Updated the portion"
  end

  protected

    def update_portion(portions, portion_params)
      ingredient = Ingredient.find(portion_params[:ingredient_id])
      portion = portions.find_or_initialize_by ingredient_id: portion_params[:ingredient_id]
      portion.additional_instructions = portion_params[:additional_instructions]
      computed_quantity = portion.determine_quantity(portion_params[:measure], normalize_quantity(portion_params.fetch(:quantity,0)))
      portion.quantity = computed_quantity
      portion.order = portion_params[:order]
      portion.include = !ingredient.pantry?
      portion.save!
    end

    def normalize_quantity quantity
      quantity.to_f / 4.0
    end

end
