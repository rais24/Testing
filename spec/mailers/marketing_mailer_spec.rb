require 'spec_helper'

describe MarketingMailer do
  let!(:site) { create :delivery_site }
  let!(:user) { create :user, :eligible, site: site }

  describe "on_site" do
    let!(:start) { Chronic.parse("tomorrow 11:30AM") }
    let!(:finish) { Chronic.parse("tomorrow 2:00PM") }
    let!(:mail) { MarketingMailer.on_site(user, start, finish) }

    it { expect(mail).to have_body_text(/#{site.name}/) }
    it { expect(mail).to have_body_text(/11:30(\w*)AM/i) }
    it { expect(mail).to have_body_text(/2:00(\w*)PM/i) }

    it "renders the headers" do
      expect(mail.subject).to include(site.name)
      expect(mail.to).to include(user.email)
      expect(mail.from).to include(MailHelper::FROM)
    end
  end
end