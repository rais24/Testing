require 'spec_helper'

describe OrderBilling do
  let(:site) { create :delivery_site }
  let(:user) { create :user, site: site }
	let(:order) { create :order, site: site }
	let(:billing) { create :billing, user: user }

	let!(:order_billing) { create :order_billing, order: order, billing: billing }

	context "when a billing is removed" do
		it "keeps a 'true' charge attribute 'true'" do
		  order_billing.update charged: true
		  order_billing.billing.destroy
		  expect(order_billing.reload.charged).to eq true
		end

		it "keeps a 'false' charge attribute 'false'" do
		  order_billing.update charged: false
		  order_billing.billing.destroy
		  expect(order_billing.reload.charged).to eq false
		end

		it "keeps a 'true' charge attribute 'true'" do
		  order_billing.update updated: true
		  order_billing.billing.destroy
		  expect(order_billing.reload.updated).to eq true
		end

		it "keeps a 'false' charge attribute 'false'" do
		  order_billing.update updated: false
		  order_billing.billing.destroy
		  expect(order_billing.reload.updated).to eq false
		end

		it "keeps a 'true' charge attribute 'true'" do
		  order_billing.update canceled: true
		  order_billing.billing.destroy
		  expect(order_billing.reload.canceled).to eq true
		end

		it "keeps a 'false' charge attribute 'false'" do
		  order_billing.update canceled: false
		  order_billing.billing.destroy
		  expect(order_billing.reload.canceled).to eq false
		end
	end
end
