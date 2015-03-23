require 'spec_helper'

shared_examples_for Quantifiable do
  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }

  describe "#empty?" do
    it "returns true if quantity is <= 0" do
      subject.quantity = 0
      expect(subject).to be_empty
    end

    it "returns false if quantity is non-zero" do
      subject.quantity = 1
      expect(subject).not_to be_empty
    end
  end
end