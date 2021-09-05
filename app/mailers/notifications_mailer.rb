class NotificationsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.order_payment_status.subject
  #
  def order_payment_status(order)
    @order_payment_status = order.payment_status

    mail to: order.user.email
  end
end
