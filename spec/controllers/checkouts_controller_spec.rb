require 'spec_helper'

# {
#   meals: {
#     next: :groceries,
#     previous: :meals
#   },
#   groceries: {
#     next: :wicked_finish,
#     previous: :meals
#   },
#   meats: {
#     next: :produce,
#     previous: :groceries
#   },
#   produce: {
#     next: :wicked_finish,
#     previous: :meats
#   }
# }
# {
#   pantry: {
#     next: :delivery,
#     previous: :pantry
#   },
#   delivery: {
#     next: :payment,
#     previous: :pantry
#   },
#   payment: {
#     next: :review,
#     previous: :delivery
#   },
#   review: {
#     next: :confirmation,
#     previous: :payment
#   },
#   confirmation: {
#     next: :wicked_finish,
#     previous: :review
#   }
# }.each do |step, neighbors|
#   describe CheckoutsController, step.to_s do
#     before do
#       puts "#{step} : #{neighbors}"
#       get :show, id: step
#     end
#
#     neighbors.each do |key, neighbor|
#       it "#{key} is #{neighbor}" do
#         expect(subject.send("#{key}_wizard_path")). to eq subject.wizard_path(neighbor)
#       end
#     end
#   end
# end

describe CheckoutsController, "checkout_path" do
  context "with a guest user" do
    before do
      @user = create(:user, :guest)
      @request.session[:user_id] = @user.id
    end
    it "should make sure a user has 8 servings" do
      cart = double(:shopping_cart, :can_checkout? => false)
      controller.stub(:cart).and_return(cart)

      get "show", id: :payment
      response.should redirect_to recipes_path
    end
    it "should redirect to the user finish page" do
      cart = double(:shopping_cart, :can_checkout? => true)
      controller.stub(:cart).and_return(cart)

      get "show", id: :payment
      response.should redirect_to "/checkouts/signup"
    end
  end
  context "with a full user" do
    before do
      @user = create(:user)
      @request.session[:user_id] = @user.id
      cart = double(:shopping_cart, :can_checkout? => true, id: 4)
      @order = create(:order, shopping_cart_id: 4, user: @user)
      controller.stub(:cart).and_return(cart)
    end
    context "entering an address" do
      context "with valid information" do
        it "should save the address and delivery time and location to the order" do
          expect{
            put "update",
                        "order"=>
                          {
                            "delivery_time"=>
                              {"delivery_date"=>"2014-03-22", "time_slot"=>"3pm-5pm"},
                            "address"=>
                              {"street1"=>"123 any st", "street2"=>"", "city"=>"Philadelphia",
                                "state"=>"PA", "zipcode"=>"19107", "phone"=>""}
                          },
                        "id" => "delivery"
          }.to change(Address, :count).by(1)
          assigns(:order).address.street1.should eq("123 any st")
          assigns(:order).address.city.should eq("Philadelphia")
          assigns(:order).address.state.should eq("PA")
          assigns(:order).address.zipcode.should eq("19107")
          assigns(:order).delivery_time.valid?.should be_true
          response.should redirect_to "/checkouts/payment"

        end
      end
      context "with invalid address information" do
        it "should reshow the delivery page and not save" do
          expect{
            put "update",
                        "order"=>
                          {
                            "delivery_time"=>
                              {"delivery_date"=>"2014-03-22", "time_slot"=>"3pm-5pm"},
                            "address"=>
                              {"street1"=>"", "street2"=>"", "city"=>"Philadelphia",
                                "state"=>"PA", "zipcode"=>"19107", "phone"=>""}
                          },
                      "id"=>"delivery"
          }.to_not change(Address, :count)
          assigns(:order).address.valid?.should be_false

          response.should render_template :delivery
        end
      end
    end
  end
end


describe CheckoutsController, '#finish_wizard_path' do
  it 'calls Checkout service' do
    service = double :service, finish_checkout_path: 'path'
    notifier = double :notifier
    order = double :order

    expect(Orders::Notifier).to receive(:new) { notifier }
    expect(subject).to receive(:next_order) { order }
    expect(service).to receive(:finish_checkout_path).with(subject.current_user)
    expect(Checkout).to receive(:new).with(subject, order, notifier) { service }

    expect(subject.finish_wizard_path).to eq 'path'
  end
end
