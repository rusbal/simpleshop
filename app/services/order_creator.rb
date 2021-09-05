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

  def execute
    ActiveRecord::Base.transaction do
      @order = create_order
      cart_items.each do |item|
        create_items(item)
      end
      @order.save!
    end
  end

  private

  def create_order
    Order.create!(user_id: user.id, shipping_address: shipping_address, total: 0)
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
  end

  def create_items(item)
    @order.order_items.create(product_id: item.id, quantity: item.quantity, price: item.price)
    @order.total += item.price * item.quantity
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
  end
end
