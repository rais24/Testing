require 'spec_helper'

describe OrderPortion do
  #it_behaves_like Portionable
  it_behaves_like Measureable
  #it_behaves_like Purchaseable
end

describe OrderPortion, "::create_from_recipe_portion" do
  let(:user) { create :user, adults: 2 }

  let(:ingredient) { create :ingredient, pantry: true }
  let(:recipe) { create :recipe }
  let(:order) { create :order, user: user }
  let(:portion) { create :recipe_portion, recipe: recipe, quantity: 2, ingredient: ingredient }

  let(:user) { build_stubbed :user, adults: 2, children: 0 }

  context "with a pre-existing OrderPortion" do
    let!(:order_portion) { create :order_portion, order: order, ingredient: ingredient, quantity: 1 }

    it "adds the quantity in relation to the family size" do
      expect(order.reload.portions).not_to be_empty
      described_class::create_from_recipe_portion(portion, quantity: user.family_size, to: order)
      expect(order.portions.first.quantity).to eq(9.0)
    end
  end

  context "with a non-existent OrderPortion" do
    it "creates an OrderPortion" do
      expect(order.portions).to be_empty
      described_class::create_from_recipe_portion(portion, quantity: user.family_size, to: order)
      sut = order.portions.reload.first
      expect(sut.quantity).to eq(8.0)
      expect(sut).not_to be_include
    end
  end
end
