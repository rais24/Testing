require 'spec_helper'

describe "Dashboard", type: :feature do
  context "as a guest" do
    let(:user) { create :user, :guest }

    it "bounces to order creation" do
      visit dashboard_path(as: user)
      expect(current_path).to match(new_order_path)
    end
  end
end