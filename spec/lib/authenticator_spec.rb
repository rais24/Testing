require 'spec_helper'

describe Authenticator do
  let(:session) { {} }
  let(:user) { build_stubbed :user }

  subject { Authenticator.new(session) }

  describe "#current_user" do

    context "with a populated session" do
      before do
        subject.login(user)
      end

      it "returns the authenticated, non-guest user" do
        current = subject.current_user

        expect(current).to eq(user)
        expect(current).not_to be_guest
      end
    end
  end

  describe "#guest?" do
    context "with an empty session" do
      it { should_not be_guest }
    end

    context "with a logged in user" do
      before do
        subject.login(user)
      end

      it { should_not be_guest }
    end
  end

  describe "#login" do
    it "populates a session" do
      expect(subject.login(user)).to eq(user)
      expect(subject.current_user).to eq(user)
    end
  end

  describe "#logout" do
    context "with an empty session" do
      it "logs out the current user" do
        subject.logout
        expect(subject.current_user).not_to eq(user)
      end

    end

    context "with a logged in user" do
      before do
        subject.login(user)
      end

      it "logs out the current user" do
        subject.logout
        expect(subject.current_user).not_to eq(user)
      end
    end
  end
end