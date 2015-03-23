class MailerWorker
  #include Sidekiq::Worker

  def perform(method, *args)
    Mailer.send(method, *args).deliver
  end
end
