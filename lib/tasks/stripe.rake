namespace :stripe do
  desc "clear the Stripe Test vault"
  task clear: :environment do
    raise StandardError if Rails.configuration.x.stripe.live

    count = ENV['COUNT'] || 100
    puts "Deleting the first #{count} Stripe customers..."
    Stripe::Customer.all(count: count.to_i).each do |json|
      Stripe::Customer.retrieve(json.id).delete
    end
    puts "Finished deleting!"
  end
end