class ActivateWorker
  include Sidekiq::Worker
  def perform(user_id)
    user = User.find(user_id)
    # if they're already activated, don't resend the email
    if user.present? && !user.active
      user.active = true
      if user.save
        UserMailer.activate(user).deliver
      end
    end
  end
end