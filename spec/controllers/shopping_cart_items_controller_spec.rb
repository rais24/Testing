require 'spec_helper'

describe ShoppingCartItemsController do
  
  describe "POST #create" do
    
    it "creates a shopping cart item" do
      recipe = create(:recipe)
      expect{
        post "create", :shopping_cart_item => {recipe_id: recipe.id, quantity: 6, price: Money.new(799) }
      }.to change(ShoppingCartItem, :count).by(1)
    end
  end

end
