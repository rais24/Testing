class EmailProcessor
  def self.process(email)
    OrderConfirmation.create!( supplier: "Shoprite",
                               raw_message: email.body,
                               recipient: email.to.first[:email]
                             )
  end
end