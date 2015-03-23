module Admin
  class RecipesController < BaseController
    def index
      @unpublished_recipes = Recipe.unscoped.unpublished.order(:created_at => :desc)
      @published_recipes = Recipe.unscoped.published.order(:published_at => :desc) # only searching published recipes
    end    

    def publish
      unless params[:new_recipes].blank?      
        Recipe.update_all({is_new: false}, nil)
        Recipe.where(id: params[:new_recipes]).update_all({is_new: true, published: true, published_at: DateTime.now})
        flash[:publish_status] = "<b>Recipes published<b>".html_safe
      else
        flash[:publish_status] = "<b>No recipes were specified for publishing<b>".html_safe
      end
      redirect_to admin_recipes_path
    end

  end
end
