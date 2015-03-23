require 'spec_helper'

shared_examples_for Purchaseable do
  include MoneyRails::TestHelpers
  
  it { should respond_to(:calculate_price) }

  it { expect(monetize(:price_cents)).to be_true }
  
end