require 'spec_helper'

describe WelcomeWorker do
  let!(:site) { build_stubbed :delivery_site }
  let!(:user) { create :user, site: site }

  it "sends a Welcome email" do
    mail = double("Mail")
    expect(mail).to receive(:deliver)
    
    expect(UserMailer).to receive(:welcome).with(user).at_most(:once) { mail }

    subject.perform(user.id)
    expect(user.new_record?).to eq(false)
  end
end
