# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StockUpdater do
  let(:stock_one) { 100 }
  let(:stock_two) { 100 }
  let(:stock_three) { 100 }
  let(:product_one) { create :product, stock: stock_one }
  let(:product_two) { create :product, stock: stock_two }
  let(:product_three) { create :product, stock: stock_three }
  let(:product_one_qty) { 1 }
  let(:product_two_qty) { 2 }
  let(:product_three_qty) { 3 }
  let(:cart_items) do
    [
      { product: product_one.id, quantity: product_one_qty, price: product_one.price },
      { product: product_two.id, quantity: product_two_qty, price: product_two.price },
      { product: product_three.id, quantity: product_three_qty, price: product_three.price }
    ]
  end
  let(:params) do
    { cart_items: cart_items }
  end

  subject { described_class.run!(params) }

  context 'when successful' do
    it 'updates stock for first product' do
      expect { subject; product_one.reload }.to change { product_one.stock }.by(-product_one_qty)
    end

    it 'updates stock for second product' do
      expect { subject; product_two.reload }.to change { product_two.stock }.by(-product_two_qty)
    end

    it 'updates stock for third product' do
      expect { subject; product_three.reload }.to change { product_three.stock }.by(-product_three_qty)
    end
  end

  context 'when failure' do
    let(:stock_one) { 0 }

    it 'returns error' do
      expect { subject }.to raise_error ActiveInteraction::InvalidInteractionError
    end
  end
end
