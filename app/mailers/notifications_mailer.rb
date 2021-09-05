class NotificationsMailer < ApplicationMailer
  def order_payment_status(order)
    @order_payment_status = order.payment_status

    mail to: order.user.email
  end
end
