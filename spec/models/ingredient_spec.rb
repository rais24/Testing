require 'spec_helper'

describe Ingredient do
  it_behaves_like Slugged do
    subject { create :ingredient }
  end
  
  subject { build_stubbed :ingredient }

  include MoneyRails::TestHelpers

  Ingredient::CATEGORIES.each do |category|
    it { should allow_value(category).for(:category) }
  end

  Ingredient::UNITS.each do |unit|
    it { should allow_value(unit).for(:unit) }
  end

  it { should have_many(:recipe_portions).dependent(:destroy) }
  it { should have_many(:order_portions).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:category) }

  it { should have_attached_file(:photo) }

  it { expect(monetize(:price_cents)).to be_true }
end
