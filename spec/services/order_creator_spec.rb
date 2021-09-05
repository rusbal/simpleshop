# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderCreator do
  let(:user) { create :user }
  let(:order) { nil }
  let(:shipping_address) { Faker::Address.full_address }
  let(:product_one) { create :product }
  let(:product_two) { create :product }
  let(:product_three) { create :product }
  let(:cart_items) do
    [
      { product: product_one.id, quantity: 1, price: product_one.price },
      { product: product_two.id, quantity: 2, price: product_two.price },
      { product: product_three.id, quantity: 3, price: product_three.price }
    ]
  end
  let(:params) do
    {
      order: order,
      user: user.id,
      shipping_address: shipping_address,
      cart_items: cart_items
    }
  end

  subject { described_class.run!(params) }

  context 'when successful' do
    let!(:payment_processor_result) { false }
    let(:paid_at) { payment_processor_result ? DateTime.current : nil }

    before do
      allow(PaymentProcessor).to receive(:run!).and_return(payment_processor_result)
    end

    it 'creates an order' do
      order = subject
      expect(order.total).to eq cart_items.sum { |x| x[:quantity] * x[:price] }
      expect(order.shipping_address).to eq(shipping_address)
      expect(order.user_id).to eq(user.id)
    end

    context 'when successful' do
      let(:order) { create :order }

      before do
        allow(Order).to receive(:create!).and_return(order)
        allow(OrderPaymentProcessorJob).to receive(:perform_in)
          .with(1.minute, order_id: order.id, paid_at: paid_at)
      end

      it 'invokes OrderPaymentProcessorJob' do
        expect(OrderPaymentProcessorJob).to receive(:perform_in)
          .with(1.minute, order_id: order.id, paid_at: paid_at)
        subject
      end
    end
  end

  context 'creates updaters an order' do
    let(:order) { create :order }

    it 'updates an existing order' do
      order = subject
      expect(order.total).to eq cart_items.sum { |x| x[:quantity] * x[:price] }
      expect(order.shipping_address).to eq(shipping_address)
      expect(order.user_id).to eq(user.id)
    end
  end
end
