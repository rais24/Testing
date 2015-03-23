require 'spec_helper'

describe ResetPasswordWorker do
  let!(:user) { create :user }
  let!(:worker) { ResetPasswordWorker.new }

  it "updates the user with the time the password reset was sent" do
    expect{ worker.perform(user.id) }.to change {
      user.reload.password_reset_sent_at }.from(nil)
  end

  it "delivers email to user" do
    expect{ worker.perform(user.id) }.to change{
      emails.length
    }.from(0).to(1)
    expect(last_email.to).to include(user.email)
  end
end