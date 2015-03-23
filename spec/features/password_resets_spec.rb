require 'spec_helper'

def confirm_password(password = "Passw0rd", password_confirmation = nil)
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password_confirmation || password
  click_button "Reset Password"
end

def send_email(email)
  click_link "Password"
  fill_in "Email", with: email
  click_button "Reset Password"
end

describe "Password Reset", type: :feature do
  let!(:user) { create :user }

  describe "/login" do
    before(:each) { visit login_path }

    it "emails a user" do
      send_email(user.email)

      expect(current_path).to eq(login_path)

      expect(page).to have_content(/sent to #{user.email}/i)
      expect(last_email.to).to include(user.email)
    end

    it "does not email invalid user" do
      email_address = "nobody@example.com"

      send_email(email_address)

      expect(current_path).to eq(password_resets_path)

      expect(page).to have_content(/email '#{email_address}' doesn't exist/i)
      expect(last_email).to be_nil
    end
  end

  describe "/password_resets/:token/edit" do
    context "with a valid, non-expired token" do
      before(:each) { visit edit_password_reset_path(user.password_reset_token) }

      it "updates the user password when confirmation matches" do
        confirm_password

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content(/reset/)
      end

      it "rejects a non-matching confirmation" do
        confirm_password("passw0rd", "Passw0rd")

        expect(page).to have_content(/doesn't match/i)
      end
    end

    it "reports when password token has expired" do
      expired = create :user, password_reset_sent_at: 5.hour.ago

      visit edit_password_reset_path(expired.password_reset_token)
      
      confirm_password

      expect(page).to have_content("expired")
    end

    it "raises record not found when password token is invalid" do
      visit edit_password_reset_path("notavalidtoken")

      expect(current_path).to eq(login_path)
      expect(page).to have_content(/try again/i)
    end
  end
end