require 'spec_helper'

describe User do
  it_behaves_like Zippable
  it_behaves_like HasSite
  
  it { should validate_numericality_of(:adults).is_greater_than(0) }
  it { should validate_numericality_of(:children).is_greater_than_or_equal_to(0) }

  User::ROLES.each do |role|
    it { should allow_value(role).for(:role) }
    it { should allow_value(role.to_s).for(:role) }
  end

  %i(guest registered without_site eligible ineligible admins recipients).each do |scope|
    it "responds to ::#{scope}" do
      expect(described_class).to respond_to(scope)
    end
  end

  describe "eligibility" do
    it "::eligible" do
      expect(User.eligible.where_values_hash['eligible']).to be
    end

    it "::ineligible" do
      expect(User.ineligible.where_values_hash['eligible']).not_to be
    end
  end

  context "during creation" do
    it "validates the password" do
      # invalid password
      user = build :user, password: "password", password_confirmation: "password"
      expect{ user.save! }.to raise_error

      # valid password
      user.password = "passw0rd"
      user.password_confirmation = "passw0rd"

      expect{ user.save! }.to be_true
    end
  end

  context "during modification" do
    let!(:user) { create :user }

    it "validates the password if it is being updated" do
      # invalid password
      user.password = "password"
      user.password_confirmation = "password"
      expect{ user.save! }.to raise_error

      # valid password
      user.password = "Passw0rd?"
      user.password_confirmation = "Passw0rd?"
      expect{ user.save! }.to be_true
    end

    it "doesn't validate the password if it is not being updated" do
      user.children = user.children + 1
      expect{ user.save! }.to be_true
    end

    it "creates a unique auth token and a unique password reset token" do
      user = build :user, auth_token: nil, password_reset_token: nil
      expect(user.auth_token).to be_nil
      expect(user.password_reset_token).to be_nil

      user.save!

      expect(user.auth_token).not_to be_nil
      expect(user.password_reset_token).not_to be_nil
    end
  end

  context "verifies roles" do
    it "regardless of string or symbol input" do
      admin_symbol = build_stubbed :user, role: :admin
      admin_string = build_stubbed :user, role: "admin"

      { admin: true, other: false }.each do |key, value|
        expect(admin_symbol.is? key).to be(value)
        expect(admin_symbol.is? key.to_s).to eq(value)
      end
    end
  end
end
