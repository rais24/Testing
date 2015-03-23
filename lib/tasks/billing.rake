namespace :billing do
  desc 'creates missing Billings from users in Stripe'
  task create_missing: :environment do
    Stripe::Customer.all.each do |customer|
      billing = Billing.find_by customer_id: customer.id
      unless billing.present?
        user = User.find_by email: customer.email
        if user.present?
          Billing.merge! customer: customer, billing: user.build_billing
        end
      end
    end
  end
end