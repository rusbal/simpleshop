FactoryBot.define do
  factory :order_item do
    quantity { rand(1..10) }
    price { rand(100..99999) }
    order
    product
  end
end
