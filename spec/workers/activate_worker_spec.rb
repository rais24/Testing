require 'spec_helper'

describe ActivateWorker do
  let!(:inactive) { create :user, active: false }
  let!(:active) { create :user, active: true }
  let!(:worker) { ActivateWorker.new }

  it "emails and activates an inactive user" do
    mail = double("Mail")
    mail.should_receive(:deliver)
    
    expect(UserMailer).to receive(:activate).with(inactive).at_least(:once) { mail }

    worker.perform(inactive.id)
    expect(inactive.new_record?).to eq(false)
    expect(User.find(inactive.id).active?).to eq(true)
  end

  it "does nothing for an active user" do
    expect(UserMailer).not_to receive(:activate)

    worker.perform(active.id)
  end
end
