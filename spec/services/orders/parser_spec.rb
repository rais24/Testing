require 'spec_helper'

describe Orders::Parser do
  context "should take an unparsed html string" do
    before do
      @raw = File.open(File.dirname(__FILE__) + '/../../fixtures/' + 'shoprite_confirmation.html', 'r').read
      @parser = Orders::Parser.new @raw
    end
    context "#get_order" do
      it "and pull out the order number" do
        @parser.get_order.should eq(132)
      end
    end
    context "#parse" do
      it "should loop over order ingredients" do
        parsed = @parser.parse

        expected = [{"4"=>"Goya BlackBeans-Premium-15.50 oz"},
                    {"2"=>"ShopRite Salsa-Mild-16.00 oz"},
                    {"1"=>"ShopRite CottageCheese-Small-16.00 oz"},
                    {"2"=>"Success Rice-Boil-in-BagWho-14.00 oz"},
                    {"4"=>"Pepper Yellow-9.00 oz/ea"},
                    {"1"=>"Garlic -1.00 oz/ea"},
                    {"4"=>"TomatoesOnTheVi Tomatoes-5.00 oz/ea"},
                    {"4"=>"RedOnions -12.00 oz/ea"},
                    {"2"=>"Cilantro -1.00 each"},
                    {"2"=>"Pepper Jalapeno-1.00 oz/ea"},
                    {"4"=>"Corn Yellow/White-1.00 ct"},
                    {"2"=>"Doritos TortillaChips-3.38 oz"}]

        parsed.should eq(expected)
      end
    end
  end
end
