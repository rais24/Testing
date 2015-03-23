require 'spec_helper'

describe PromosController do
  context "POST 'create'" do
    before do
      @promo = create(:promo)
      @cart = create(:shopping_cart)
      controller.stub(:cart).and_return(@cart)
      controller.stub(:authenticate).and_return(true)
    end
    
    context "with a valid promo" do
      it "should create a used promo for the shopping cart" do
        expect{ 
          post :create, promo: {code: 'promo1'}
        }.to change(UsedPromo,:count).by(1)
      end
      it "should redirect to cart with a success message" do
        post :create, promo: {code: 'promo1'}
        flash[:notice].should eq("Promotion applied")
        response.should redirect_to shopping_cart_path
      end
    end
    
    context "with an invalid promo" do
      it "should not create a used promo" do
        expect{
          post :create, promo: {code: 'promo2'}
        }.to_not change(UsedPromo, :count)
      end
      it "should redirect to cart with an error message" do
        post :create, promo: {code: 'promo2'}
        flash[:alert].should eq("Didn't recognize promotion")
      end
    end
  end
end
