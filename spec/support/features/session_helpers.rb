module Features
  module SessionHelpers
    def login(email, password)
      visit login_path
      fill_in "email", with: email
      fill_in "password", with: password
      click_button "Login"
    end

    def register(zipcode, email, password, confirm = nil)
      visit new_user_url

      within "#new_user" do
        fill_in "user_zipcode", with: zipcode
        fill_in "user_email", with: email
        fill_in "user_password", with: password
        fill_in "user_password_confirmation", with: confirm || password
        find("input[type=submit]").click
      end
    end
  end
end