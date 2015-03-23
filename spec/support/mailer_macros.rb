module MailerMacros
  def emails
    ActionMailer::Base.deliveries
  end

  def last_email
    emails.last
  end

  def clear_emails
    ActionMailer::Base.deliveries = []
  end
end