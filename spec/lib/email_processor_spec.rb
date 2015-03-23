require 'spec_helper'

describe EmailProcessor do
  let(:email) { build :email }
  describe "#process" do
    it "should create an order_confirmation" do
      expect{
        EmailProcessor.process(email)
      }.to change(OrderConfirmation,:count).by(1)
      expect(OrderConfirmation.last.recipient).to eq("to_user@email.com")
    end
  end
end