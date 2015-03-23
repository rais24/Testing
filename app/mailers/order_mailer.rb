class OrderMailer < ActionMailer::Base
  helper MailHelper
  
  default from: "The Fitly Family (contact@fitly.org)"

  def confirmation(order)
    @order = order
    @user = @order.user
    @site = @user.site
    @address = @site.address

    mail to: order.user.email
  end

  def admin_confirmation(order)

  end
end
