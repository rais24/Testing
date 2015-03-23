require 'spec_helper'

describe ShoppingCarts::Pricing, 'updating a cart' do
  before do
    @cart = ShoppingCart.create
    @cart.add(create(:recipe), 7.99, 4)
    @cart.add(create(:recipe), 7.99, 4)
    @cart.add(create(:ingredient), 1.99, 1)
  end
  
  context "with a new recipe that puts servings over 8" do
    it "should update other cart items" do
      Pricing.update(@cart)
      expect(@cart.total).to eq( 65.91 )
      @cart.add(create(:recipe), 6.99, 4)
      @cart.reload
      Pricing.update(@cart)
      expect(@cart.total).to eq( 85.87 )
    end
  end
  context "with a new recipe that puts servings over 19" do
    it "should update other cart items" do
      Pricing.update(@cart)
      expect(@cart.total).to eq( 65.91 )
      @cart.add(create(:recipe), 6.99, 12)
      @cart.reload
      Pricing.update(@cart)
      expect(@cart.total).to eq( 121.79 )
    end
  end
end