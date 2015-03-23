require 'spec_helper'

describe Orders::Notifier, '#notify' do
  let(:worker_class) { MailerWorker }
  after do
    subject.notify(order)
  end

  context 'with an order' do
    let(:order) { build_stubbed :order }

    it 'sends both order and admin order confirmation emails' do
      expect(worker_class).to receive(:perform_async).with(:order_confirmation, order.id)
      expect(worker_class).to receive(:perform_async).with(:admin_order_confirmation, order.id)
    end
  end

  context 'with a nil order' do
    let(:order) { nil }

    it 'does not send any emails' do
      expect(worker_class).not_to receive(:perform_async)
    end
  end
end