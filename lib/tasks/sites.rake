namespace :sites do
  desc "Associate orphan users with delivery site in the same zip"
  task users_by_zip: :environment do
    DeliverySite.find_each do |site|
      User.without_site.where(zipcode: site.zip).each do |user|
        site.users << user
        user.save!
      end
      site.save!
    end
  end
end