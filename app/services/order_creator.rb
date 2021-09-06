class OrderCreator < ActiveInteraction::Base
  record :user
  string :shipping_address
  array :cart_items do
    hash do
      record :product
      integer :quantity
      integer :price
    end
  end
  record :order, default: nil

  def execute
    validate!

    ActiveRecord::Base.transaction do
      set_order.tap do |order|
        order.total = 0
        order.user = user
        order.shipping_address = shipping_address
        order.order_items.destroy_all
        cart_items.each do |item|
          create_items(order, item)
        end
        order.save!

        OrderPaymentProcessorJob.perform_in(1.minute, order_id: order.id, paid_at: payment_processor)
      end
    end
  end

  private

  def validate!
    with_not_enougth_stock.each do |item|
      errors.add(:base, "Not enough stock for #{item[:product].title}.")
    end
  end

  def with_not_enougth_stock
    cart_items.filter { |x| x[:quantity] > x[:product].stock }
  end

  def payment_processor
    PaymentProcessor.run!
  end

  def set_order
    return order if order&.present?

    Order.create!(user_id: user.id, shipping_address: shipping_address, total: 0)
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
  end

  def create_items(order, item)
    order.order_items.create(product_id: item[:product].id, quantity: item[:quantity], price: item[:price])
    order.total += item[:price] * item[:quantity]
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
  end
end
