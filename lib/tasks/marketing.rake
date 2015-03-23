require 'chronic'


namespace :mail do
  namespace :marketing do

    def site_from_env
      raise "Please set SITE=<promo_code>" unless ENV['SITE'].present?
      DeliverySite.find_by! promo_code: ENV['SITE']
    end

    def start_from_env
      ENV['START']  || '11:30AM'
    end

    def finish_from_env
      ENV['FINISH'] || '2:00AM'
    end

    def tomorrow(*times)
      times.to_a.map { |t| Chronic.parse("Tomorrow #{t}") }
    end

    def send_to(users, start, finish)
      puts "Sending email to #{users.count} users..."
      users.each_with_index do |user, index|
        MarketingMailer.on_site(user, start, finish).deliver
        puts "\t - Sent to #{user.email} (#{index + 1} out of #{users.count} users)"
      end
    end

    desc """
    Ping all users that we'll be on site. 
    SITE=<promo_code>, START=11:30AM, FINISH=2:00PM
    """
    task on_site: :environment do
      start, finish = tomorrow(start_from_env, finish_from_env)
      send_to(site_from_env.users.all, start, finish)
    end

    namespace :on_site do

      desc """
      Ping all elgibile users that we'll be on site. 
      SITE=<promo_code>, START=11:30AM, FINISH=2:00PM
      """
      task eligible: :environment do
        start, finish = tomorrow(start_from_env, finish_from_env)

        send_to(site_from_env.users.where(eligible: true), start, finish)
      end

      desc """
      Ping all inelgibile users that we'll be on site. 
      SITE=<promo_code>, START=11:30AM, FINISH=2:00PM
      """
      task ineligible: :environment do
        start, finish = tomorrow(start_from_env, finish_from_env)

        send_to(site_from_env.users.where(eligible: false), start, finish)
      end
    end
  end
end