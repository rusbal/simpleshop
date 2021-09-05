# Preview all emails at http://localhost:3000/rails/mailers/notifications
class NotificationsPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifications/order_payment_status
  def order_payment_status
    NotificationsMailer.order_payment_status
  end

end
