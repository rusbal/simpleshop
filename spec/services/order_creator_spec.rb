# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderCreator do
  let(:user) { create :user }
  let(:shipping_address) { Faker::Address.full_address }
  let(:product_one) { create :product }
  let(:product_two) { create :product }
  let(:product_three) { create :product }
  let(:cart_items) do
    [
      { product: product_one.id, quantity: 1, price: product_one.price },
      { product: product_two.id, quantity: 2, price: product_two.price },
      { product: product_three.id, quantity: 3, price: product_three.price },
    ]
  end
  let(:params) do
    {
      user: user.id,
      shipping_address: shipping_address,
      cart_items: cart_items
    }
  end

  subject { described_class.run!(params) }

  it 'creates an order' do
    order = subject
    expect(order.total).to eq cart_items.sum { |x| x.quantity * x.price }
    expect(order.shipping_address).to eq(shipping_address)
    expect(order.user_id).to eq(user.id)
  end
end
