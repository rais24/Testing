class UserMailer < ActionMailer::Base
  helper MailHelper
  
  default from: MailHelper::FROM

  def activation user
    @user = user
    mail to: @user.email, subject: "Welcome to Fitly"
  end

  def welcome(user)
    @user = user
    @unlock_link = unlock_user_url(user, auth_token: user.auth_token)
    mail to: @user.email, subject: "Welcome to Fitly"
  end

  def activate(user)
    @user = user
    @site = user.site
    mail to: @user.email, subject: "Thanks for Registering, #{@user.first}!"
  end

  def password_reset(user)
    @user = user
    mail to: @user.email, subject: "Reset your Fitly Password"
  end

  def welcome_subscriber(subscription)
    @subscription = subscription
    @subscriber = subscription.user
  end

  def pause_subscription(subscription)
    @subscription = subscription
    @subscriber = subscription.user
  end

  def resume_subscription(subscription)
    @subscription = subscription
    @subscriber = subscription.user
  end

end
