require "spec_helper"

describe UserMailer do
  describe "#welcome" do
    let!(:site) { create :delivery_site}
    let!(:user) { create :user, site: site }
    let!(:mail) { UserMailer.welcome(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome to the Fitly Family")
      expect(mail.to).to include(user.email)
      expect(mail.from).to include(MailHelper::FROM)
    end
  end

  describe "#password_reset" do
    let(:user) { create :user }
    let!(:mail) { UserMailer.password_reset(user) }

    it "sends user password reset url" do
      expect(mail.subject).to eq("Reset your Fitly Password")
      expect(mail.to).to include(user.email)
      expect(mail.from).to include(MailHelper::FROM)
      expect(mail).to have_body_text(edit_password_reset_path(user.password_reset_token))
    end
  end
end