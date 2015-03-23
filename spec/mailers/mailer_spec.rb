require "spec_helper"

describe Mailer do
  let(:site) { build_stubbed(:delivery_site) }
  let(:recipient) { build_stubbed(:user, site: site) }

  describe "#order_confirmation" do
    let(:order) { build_stubbed :order, user: recipient, site: site }
    let(:mail) { Mailer.order_confirmation(order.id) }

    before do
      expect(Order).to receive(:find).with(order.id) { order }
    end

    it "renders the headers" do
      expect(mail.subject).to match /#{order.full_date}/i
      expect(mail.to).to include(recipient.email)
      expect(mail.from).to include(Mailer::FROM)
    end
  end

  describe "#admin_order_confirmation" do
    let(:order) { build_stubbed :order, user: recipient, site: site }
    let(:mail) { Mailer.admin_order_confirmation(order.id) }

    before do
      expect(Order).to receive(:find).with(order.id) { order }
    end

    it "renders the headers" do
      expect(mail.subject).to match /#{order.report_name}/i
      expect(mail.to).to include(Mailer::ORDERS)
      expect(mail.from).to include(Mailer::FROM)
    end
  end

  describe "#checkout_failure" do
    let(:order) { build_stubbed :order, user: recipient, site: site }
    let(:mail) { Mailer.checkout_failure(order, "An error occured during the email delivery") }

    it "renders the headers" do
      expect(mail.subject).to match /ORDER CHECKOUT FAILED - Fitly Order ID #{order.id}/i
      #expect(mail.to).to include(Mailer::ORDERS)
      expect(mail.body).to include("A Fitly order failed to checkout and requires your immediate attention")
    end
  end

end
