require 'spec_helper'

describe ShoppingCart do    
  context 'current price' do
    before do
      @cart = create :shopping_cart
    end
    context 'with 8 servings' do
      it 'should be 7.99' do
        allow(@cart).to receive(:servings).and_return(8)
        expect(@cart.current_price_per_serving).to eq( Money.new(799) )
      end
    end
    context 'with 12 servings' do
      it 'should be 6.99' do
        allow(@cart).to receive(:servings).and_return(12)
        expect(@cart.current_price_per_serving).to eq( Money.new(699) )
      end
    end
    context 'with 20 servings' do
      it 'should be 5.99' do
        allow(@cart).to receive(:servings).and_return(20)
        expect(@cart.current_price_per_serving).to eq( Money.new(599) )
      end
    end
  end
  context 'servings' do
    context 'with an empty cart' do
      it 'should give 0' do
        cart = ShoppingCart.new
        cart.servings.should eq(Money.new(0))
      end
    end
  end
  context "#total_price" do
    before do
      @cart = create :shopping_cart
      @cart.stub(subtotal: 63.92, taxes: 0.0, shipping_cost: 0.0)
    end
    it "should calculate price without promo" do
      expect(@cart.total).to eq(63.92)
      #("%.2f" % regular_total).to_f
    end
    it "should calculate price with discount promo" do
      used_promo = double(UsedPromo, amount_off: Money.new(2500), discount: Money.new(2500))
      @cart.stub(used_promo: used_promo)
      expect(@cart.total).to eq(38.92)
    end
    it "should calculate the price with discount percent promo" do
      used_promo = double(UsedPromo, amount_off: Float(0.25), discount: Money.new(0), discount_percent: Float(0.25))
      @cart.stub(used_promo: used_promo)
      expect(@cart.total).to eq(47.94)
    end
  end
  context "#discount_from_promo" do
    before do
      @cart = create :shopping_cart
    end
    it "should display amount off if discount is > 0" do
      used_promo = double(UsedPromo, amount_off: Money.new(2500), discount: Money.new(2500))
      @cart.stub(used_promo: used_promo)
      @cart.discount_from_promo.should eq(Money.new(2500))
    end
  end
  context "adding a promo with #add_promo" do
    context "adding a valid promo" do
      before do
        @cart = create :shopping_cart
        @promo = create :promo
      end
      it "should add a used promo code and return true" do
        expect(@cart.add_promo(@promo)).to eq(true)
        expect(@cart.used_promo).not_to be_nil 
      end
    end
    context "adding an invalid promo" do
      before do
        @cart = create :shopping_cart
        @promo = create :promo, starts_on: Date.today-30.days, ends_on: Date.today-15.days
      end
      it "should not add a promo that has expired" do
        expect(@cart.add_promo(@promo)).to eq(false)
        expect(@cart.used_promo).to be_nil
      end
      it "should not add a promo that is used up" do
        @promo.starts_on = Date.today - 1.day
        @promo.ends_on = Date.today + 29.days
        @promo.quantity = 25
        @promo.save!
        @promo.stub(total_used: 25)
        
        expect(@cart.add_promo(@promo)).to eq(false)
        expect(@cart.used_promo).to be_nil
      end
    end
  end
end
