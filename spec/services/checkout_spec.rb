require 'spec_helper'

describe Checkout, '#finish_checkout_path' do
  context 'with a guest' do
    it 'returns the new user path' do
      url_helpers = double(new_user_path: 'path')
      user = double(guest?: true)
      expect(Checkout.new(url_helpers, nil).finish_checkout_path(user)).to eq 'path'
    end
  end

  context 'with a registered user' do
    context 'without a billing' do
      it 'returns the new billing path' do
        url_helpers = double(new_billing_path: 'path')
        user = double(guest?: false, billing: nil)
        expect(Checkout.new(url_helpers, nil).finish_checkout_path(user)).to eq 'path'
      end
    end

    context 'with a billing' do
      it 'returns the order path' do
        url_helpers = double :url_helpers, order_path: 'path'
        user = double :user, guest?: false, billing: Object.new
        expect(Checkout.new(url_helpers, double(:order)).finish_checkout_path(user)).to eq 'path'
      end
    end
  end
end

describe Checkout, '#checkout' do
  let(:notifier) { double :notifier }
  let(:order) { double :order }

  after do
    Checkout.new(nil, order, notifier).checkout
  end

  context 'with and order that is deliverable' do
    before do
      expect(order).to receive(:deliverable?) { true }
    end

    context 'with an order that has not been checked out' do
      before do
        expect(order).to receive(:checked_out?) { false }
      end

      it "updates the order's checked_out to true" do
        expect(order).to receive(:update!).with(checked_out: true)
        expect(notifier).to receive(:notify).with(order)
      end

      it 'calls the notifier' do
        expect(order).to receive(:update!).with(checked_out: true)
        expect(notifier).to receive(:notify).with(order)
      end
    end

    context 'with an order that has been checked out' do
      before do
        expect(order).to receive(:checked_out?) { true }
      end

      it 'does not update the order' do
        expect(order).not_to receive(:update!)
      end

      it 'does not notify anyone' do
        expect(notifier).not_to receive(:notify)
      end
    end
  end

  context 'with and order that is not deliverable' do
    before do
      expect(order).to receive(:deliverable?) { false }
    end
    it 'does not update the order' do
      expect(order).not_to receive(:update!)
    end

    it 'does not notify anyone' do
      expect(notifier).not_to receive(:notify)
    end
  end
end