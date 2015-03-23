require File.expand_path('../../environment', __FILE__)

Replicate::AR

unless ENV['SITE'].present?
  raise StandardError.new("Please set SITE=<promo_code>.")
end

limit = ENV['LIMIT'].try(:to_i) || 20 
site  = DeliverySite.find_by! promo_code: ENV['SITE']

dump site
dump site.users.limit(limit)
dump site.deliveries.limit(limit)