require 'spec_helper'

describe Routing::AdminConstraint, '::matches?' do
  let(:request) { double(session: { user_id: user.id }) }

  before do
    expect(User).to receive(:find).with(user.id) { user }
  end

  context "as an admin" do
    let(:user) { build_stubbed :admin }
    it "returns true" do
      expect(subject.matches?(request)).to be
    end
  end

  context "as a normal user" do
    let(:user) { build_stubbed :user }

    it "returns false" do
      expect(subject.matches?(request)).not_to be
    end
  end

  context "as a guest" do
    let(:user) { build_stubbed :user, :guest }

    it "returns false" do
      expect(subject.matches?(request)).not_to be
    end
  end
end