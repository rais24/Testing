require 'spec_helper'

describe "the registration process", type: :feature do
  context "with an unauthenticated user" do

    it "welcomes a registered user via email" do
      user = build :user
      register(user.zipcode, user.email, user.password)

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content /activate/i

      recipient = User.find_by email: user.email

      expect(last_email.to).to include(recipient.email)
      expect(last_email.subject).to include("Welcome")
      expect(last_email.body.encoded).to include(unlock_user_path(recipient, auth_token: recipient.auth_token))
    end

    # it "welcomes a guest user without an email" do
    #   guest = create :user, :guest
    #   register(guest.zipcode, guest.email, guest.password)

    #   expect(current_path).to eq(registration_path)

    #   recipient = User.find_by email: user.email

    #   expect(last_email).to be_nil
    # end

    context "with invalid input" do
      let!(:user) { build :user }
      it "doesn't allow duplicate emails values" do
        user = create :user

        register(user.zipcode, user.email, user.password)

        expect(page).to have_content "taken"
      end

      it "doesn't allow invalid passwords" do
        user = build :user

        register(user.zipcode, user.email, "invalid")

        expect(page).to have_content "must contain"
      end

      it "password and confirmation must match" do
        user = build :user

        register(user.zipcode, user.email, "pass", "word")

        expect(page).to have_content(/doesn\'t match Password/i)
      end
    end
  end

  context "with an authenticated user" do
    before(:each) do
      user = build :user
      register(user.zipcode, user.email, user.password)
      @user = User.find_by email: user.email
    end

    it "unlocks a user via email" do
      # click the unlock link
      visit unlock_user_path(@user, auth_token: @user.auth_token)
      # expect redirect to registration
      expect(current_path).to eq(registration_path)
      expect(page).to have_content(@user.email)
    end

    it "allows for resending of the unlock email" do
      @user.update! locked: true
      visit dashboard_path
      click_link "send it again"
      expect(last_email.to).to include(@user.email)
      expect(last_email.subject).to include("Welcome")
      expect(last_email.body.encoded).to include(unlock_user_path(@user, auth_token: @user.auth_token))
    end
  end


  context "with an inactive user" do
    let!(:user) { create :user, locked: false, active: false }

    it "redirects to registration" do
      login(user.email, user.password)
      expect(current_path).to eq(registration_path)
    end
  end
end