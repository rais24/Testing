require 'chronic'

namespace :orders do
  desc 'Schedule all floating orders for this Friday'
  task schedule: :environment do
    Order.where(scheduled_for: nil).find_each do |order|
      order.update! scheduled_for: Chronic.parse('this friday')
    end
  end

  namespace :dev do
    desc "Clear all orders"
    task clear: :environment do
      Order.destroy_all
    end
  end
end