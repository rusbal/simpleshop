class OrderPaymentProcessorJob
  include Sidekiq::Worker

  def perform(order_id:, paid_at: nil)
    return if paid_at.nil?

    order = Order.find_by(id: order_id)
    return if order.nil?
    return if order.paid_at.present?

    order.update(paid_at: paid_at)
  end
end
