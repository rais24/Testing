class RecipesController < InheritedResources::Base
  include SluggedResource
  before_filter :set_search_filter, :only => [:index]
  skip_load_resource :only => [:index]
  skip_authorize_resource :only => [:index, :show]
  skip_before_filter :authenticate, :only => [:index, :show]

  def index
    @scope = Recipe.unscoped.published.order(:published_at => :desc) # only searching published recipes
    @filters = []
    Recipe::FILTERS.each{ |x| process_filters(x) }

    #Rails.logger.warn @filters.to_yaml
    @scope = @scope.tagged_with(session[:filters][:dietary_need], on: :dietary_need, any: true) unless session[:filters][:dietary_need].blank?
    @scope = @scope.tagged_with(session[:filters][:main_dish], on: :main_dish, any: true) unless session[:filters][:main_dish].blank?
    @scope = @scope.tagged_with(session[:filters][:prep], on: :prep) unless session[:filters][:prep].blank?
    @scope = @scope.tagged_with(session[:filters][:diet_type], on: :diet_type) unless session[:filters][:diet_type].blank?
    @scope = @scope.tagged_with(params[:tags].split(','), any: true) if params[:tags].present?
    @counter=0
    @scope.each do |s|
      @counter +=1
    end
    @recipes = @scope
    render :layout => false
  end

  def show
    if params[:prepview].present? && params[:prepview] == "on" && !current_user
      render inline: "<p>Please sign in to view the recipe instructions.</p>", layout: true
    else
      render :layout => false
    end
  end

  def new
    @recipe.portions.build
  end

  def clear_portions
    @recipe.portions.each do |p|
      p.destroy
    end
    redirect_to @recipe
  end

  def collection
    @projects ||= end_of_association_chain.published
  end

  private 

  def permitted_params
    params.
      permit recipe: [:name, :photo, :nutrition, :preparation, :prep_time, :cook_time, 
                      :published, :source, :meal, :description, :main_dish_list, 
                      :prep_list, :diet_type_list, :dietary_need_list]
  end

  def recipe_params
    params.require(:recipe).permit(:name, :photo, :nutrition, :preparation, :prep_time, 
                      :cook_time, :published, :source, :meal, :description, :main_dish_list, 
                      :prep_list, :diet_type_list, :dietary_need_list)
  end

  def process_filters category
    if params[:filter] && params[:filter][category]
      params[:filter][category].each do |key, val|
        session[:filters][category] << val
        @filters << val
      end
    end
  end

  def set_search_filter
    session[:filters] = {}
    session[:filters][:dietary_need] = []
    session[:filters][:main_dish] = []
    session[:filters][:prep] = []
    session[:filters][:diet_type] = []
  end
end
