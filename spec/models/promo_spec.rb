require 'spec_helper'

describe Promo do
  before do
    @promo = create :promo
  end
  context "finding used quantity" do
    it "should return the amount of used promos with a given code" do
      @promo.total_used.should eq(0)
    end
  end
  context "amount_off" do
    it "should return a discount of cents when discount is populated" do
      @promo.stub(discount: Money.new(2500))
      @promo.amount_off.should eq(Money.new(2500))
    end
    it "should return a discount percentage when discount is not populated and discount_percent is" do
      @promo.stub(discount: Money.new(0), discount_percent: 25)
      @promo.amount_off.should eq(Float(0.25))
    end
  end
end
