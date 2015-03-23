class ResetPasswordWorker
  include Sidekiq::Worker

  # Public: set a User's password reset token, update the 
  #         password reset clock, and send an email containing
  #         the user's reset link.
  #
  # user_id - the ID of the user to reset
  #
  def perform(user_id)
    user = User.find(user_id)
    # reset the clock
    user.password_reset_sent_at = Time.zone.now

    # send the email if the user saves
    UserMailer.password_reset(user).deliver if user.save!
  # We DON'T want to retry missing records
  rescue ActiveRecord::RecordNotFound => ex
    puts ex.message
  end
end