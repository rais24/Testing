class BillingsController < InheritedResources::Base
  defaults singleton: true

  def show
    if resource.new_record?
      redirect_to(new_billing_path)
    else
      show!
    end
  end

  def edit
    if resource.new_record?
      redirect_to(new_billing_path)
    else
      show!
    end
  end

  def new
    if resource.persisted?
      redirect_to(billing_path)
    else
      new!
    end
  end

  def create
    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create a Customer
    customer = Stripe::Customer.create(
      card: token,
      email: current_user.email,
      description: current_user.name
    )
    handle_result(customer, error_action: :new)
  end

  def update
    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    customer = Stripe::Customer.retrieve(resource.customer_id)
    customer.card = token

    handle_result(customer.save, error_action: :edit)
  end

  def destroy
    customer = Stripe::Customer.retrieve(resource.customer_id)
    if card = customer.active_card
      card.delete
    end

    resource.disable!
    redirect_to billing_path
  end

  protected
    def resource
      current_user.billing || build_resource
    end

    def checkout
      @checkout ||= Checkout.new(self, next_order, Orders::Notifier.new)
    end

    def build_resource(attributes = {})
      Billing.new(attributes.merge(user_id: current_user.id))
    end

    def handle_result(customer, error_action: :new)
      Billing.merge!(customer: customer, billing: resource)
      checkout.checkout
      redirect_to billing_path
    rescue StandardError => ex
      puts ex.message
      flash.now[:alert] = "Failed to save!"
      render error_action
    end
end