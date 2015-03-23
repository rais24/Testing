require 'spec_helper'

describe OrderBillingWorker, '#perform' do
  let(:site) { build_stubbed :delivery_site }
  let(:user) { build_stubbed :user, site: site }
  let(:billing) { build_stubbed :billing, user: user }

  let(:order) { build_stubbed :order, site: site }

  let!(:order_billing) { build_stubbed :order_billing, order: order, billing: billing }

  context "responds to" do
    before(:each) do
      OrderBilling.stub(:find) { |*args| order_billing if args.to_a[0] == order_billing.id }
    end

    %i(charge! refund! recharge! cancel!).each do |message|
      it "responds to #{message}" do
        expect(order_billing).to receive message

        subject.perform(order_billing.id, message)
      end
    end
  end
end
