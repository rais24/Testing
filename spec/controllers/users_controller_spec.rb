require 'spec_helper'

describe UsersController, "#create" do
  context "with a guest user" do
    before do
      @user = create(:user, :guest)
      @request.session[:user_id] = @user.id
    end
    context "with invalid data" do
      it "should not update a user" do
        put :complete, id: @user, user: {guest: false, email: 'test@email.com', first: 'adrian', last: 'test', password: 'xxyz'}
        controller.current_user.reload.first.should eq( nil )
        
        response.should render_template :new
      end
    end
    context "with valid data" do
      it "should update a user" do
        put :complete, id: @user, user: {guest: false, email: 'test@email.com', zipcode: 12345, first: 'adrian', last: 'test', password: 'xxyz1', password_confirmation: 'xxyz1'}
        controller.current_user.first.should eq("adrian")
        
        response.should redirect_to(checkout_path)
      end
    end
  end
end