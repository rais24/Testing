class MarketingMailer < ActionMailer::Base
  helper MailHelper
  
  default from: MailHelper::FROM

  def on_site(user, start, finish)
    @user  = user
    @site  = user.site
    @start, @finish = [start,finish].map { |t| t.strftime("%I:%M%p") }

    mail to: @user.email, subject: "Fitly is Coming To #{@site.name}!"
  end

  def finish_registration(user)

  end
end
