class WelcomeWorker
  include Sidekiq::Worker
  
  def perform(user_id)
    UserMailer.welcome(User.find(user_id)).deliver
  # We DON'T want to retry missing records
  rescue ActiveRecord::RecordNotFound => ex
    puts ex.message
  end
end