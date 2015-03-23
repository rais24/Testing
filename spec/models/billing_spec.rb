require 'spec_helper'

describe Billing do
	it { should have_many(:charges) }
	it { should have_many(:orders).through(:charges) }

	let!(:user) { create :user }

	it "successfully creates a single new Billing" do
		before = Billing.all.count
		billing = Billing.create(user: user)
		after = Billing.all.count

		expect(after).to eq(before + 1)
	end

	it "fails to create a single new Billing" do
		before = Billing.all.count
		billing = Billing.create()
		after = Billing.all.count

		expect(after).to eq(before)
	end

	describe "::charge!" do
		before(:each) do
			@customer = Stripe::Customer.create(email: user.email, card: {
				number: "4242424242424242", exp_month: 1, exp_year: 1.year.from_now.year
			})
			@card = @customer.active_card
			@billing = build :billing, user: user
		end

		if 'should create a charge' do
			
		end
	end

	describe "::merge!" do
		before(:each) do
			@customer = Stripe::Customer.create(email: user.email, card: {
				number: "4242424242424242", exp_month: 1, exp_year: 1.year.from_now.year
			})
			@card = @customer.active_card
			@billing = build :billing, user: user
		end

		it "merges a Billing with a Stripe::Customer" do
			Billing.merge!(customer: @customer, billing: @billing)

			expect(@billing).not_to be_new_record
			expect(@billing.customer_id).to eq(@customer.id)
			expect(@billing.token).to eq(@card.fingerprint)
			expect(@billing.last_4).to eq(@card.last4)
			expect(@billing.expiration_month).to eq(@card.exp_month)
			expect(@billing.expiration_year).to eq(@card.exp_year)
			expect(@billing.card_type).to eq(@card.type)
		end

		it "returns false with improper arguments and no bang" do
			expect(Billing.merge).to be_false
		end

		it "raises an error with a bang!" do
			expect{Billing.merge!}.to raise_error
		end
	end
end
