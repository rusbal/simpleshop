class StockUpdater < ActiveInteraction::Base
  array :cart_items do
    hash do
      record :product
      integer :quantity
    end
  end

  def execute
    cart_items.each do |item|
      product = item[:product]
      product.stock -= item[:quantity]
      errors.add(:base, "Not enough stock for #{item[:product].title}.") if product.stock < 0
      product.save!
    end
  end
end
