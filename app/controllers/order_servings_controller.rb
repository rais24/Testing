class OrderServingsController < InheritedResources::Base
  defaults collection_name: :servings
  belongs_to :order
  load_and_authorize_resource through: :order

  after_filter ->{ update_order parent }, only: [:create, :update, :destroy]

  # 
  # create an OrderServing if a serving for the `:recipe_id` doesn't already
  # exist
  def create
    unless @order.servings.find_by(recipe_id: recipe_id)
      create!
    end
  end

  # 
  # expected parameters for CRUD
  # 
  # @return [Hash] the sanitized parameters
  def permitted_params
    params.permit order_serving: [:quantity, :recipe_id]
  end

  def recipe_id
    params.fetch(:order_serving, {})[:recipe_id].to_i
  end
end
