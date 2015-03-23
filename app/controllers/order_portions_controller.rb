class OrderPortionsController < InheritedResources::Base
  defaults collection_name: :portions
  belongs_to :order
  load_and_authorize_resource :portions, through: :order, class: OrderPortion

  def reset
    collection.find_each do |portion|
      portion.update! include: true
    end
  end

  def permitted_params
    params.permit order_portion: [:quantity, :include]
  end

  private
    helper_method :meats, :produce, :groceries, :excluded
    def meats
      @order.portions.where(ingredients: { category: :meats })
    end

    def produce
      @order.portions.where(ingredients: { category: :produce })
    end

    def groceries
      @order.portions.where(ingredients: { category: :groceries })
    end

    def excluded
      @order.portions.excluded
    end
end
