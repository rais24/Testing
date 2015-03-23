namespace :users do
  namespace :guests do
    desc "Remove all guest users"
    task delete: :environment do
      Order.guest.readonly(false).destroy_all
      User.guest.readonly(false).destroy_all
    end
  end
end