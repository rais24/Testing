require 'spec_helper'

describe OrderStoreIngredient do
  it_behaves_like Measureable
  it { should belong_to(:order) }
  it { should belong_to(:store_ingredient) }
  it { should validate_presence_of(:quantity)}
  it { expect(monetize(:price_cents)).to be_true }

  let(:order) { create :order, site: site }
  let(:store_ingredient) { create :store_ingredient }
  let!(:order_store_ingredient) { create :order_store_ingredient, order: order, store_ingredient: store_ingredient }

  it "should have a total price" do
  	subject.total_price.should == 0
  end
end
