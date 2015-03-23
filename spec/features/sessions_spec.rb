require 'spec_helper'

describe "Session", type: :feature do
  it "authenticates with a valid email/password combo" do
    user = create :user
    
    login user.email, user.password

    current_path.should eq(dashboard_path)
  end

  it "bounces with an invalid password" do
    user = create :user

    login user.email, "notthepassword"

    current_path.should eq(login_path)
    page.should have_content("combination")
  end

  it "bounces with an invalid email" do
    user = create :user

    login "notanemail", user.password

    current_path.should eq(login_path)
    page.should have_content("combination")
  end

  it "password reset link starts reset process" do
    visit login_path
    click_link "Password"

    current_path.should eq(password_resets_path)
    page.should have_content("Reset")
  end
  
end