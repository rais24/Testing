class MealPlanRecipesController < ApplicationController

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
