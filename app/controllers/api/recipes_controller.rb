module API
  class RecipesController < InheritedResources::Base
    include SluggedResource
    skip_load_resource :only => [:index]
    skip_authorize_resource :only => [:index, :show]
    skip_before_filter :authenticate

    def index
      @scope = Recipe.unscoped.published.order(:published_at => :desc) # only searching published recipes
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
      render json: @recipes, status: 200
    end

    private 

  end
end