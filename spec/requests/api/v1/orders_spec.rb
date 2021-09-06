# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::OrdersController do
  let(:user) { create(:user) }
  let(:token) { jwt_sign_in(email: user.email, password: user.password) }
  let(:headers) do
    { authorization: "JWT #{token}" }
  end
  let(:json_format) do
    {
      except: %i[
        id
        user_id
        created_at
        updated_at
      ]
    }
  end
  let(:shipping_address) { Faker::Address.full_address }
  let(:stock_one) { 100 }
  let(:stock_two) { 100 }
  let(:stock_three) { 100 }
  let(:product_one) { create :product, stock: stock_one }
  let(:product_two) { create :product, stock: stock_two }
  let(:product_three) { create :product, stock: stock_three }
  let(:cart_items) do
    [
      { product_id: product_one.id, quantity: 1, price: product_one.price },
      { product_id: product_two.id, quantity: 2, price: product_two.price },
      { product_id: product_three.id, quantity: 3, price: product_three.price },
    ]
  end
  let(:params) do
    {
      order: {
        user_id: user.id,
        shipping_address: shipping_address,
        cart_items: cart_items
      }
    }
  end

  describe 'GET /api/v1/orders' do
    let!(:orders) { FactoryBot.create_list(:order, 3, user: user) }
    let(:expected_body) { orders.as_json(json_format) }

    subject { get '/api/v1/orders', headers: headers }

    it 'returns a list of orders with products' do
      subject
      expect(response.parsed_body).to include_json(expected_body)
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/orders/:id' do
    let!(:order) { create(:order, user: user) }
    let(:expected_body) { order.as_json(json_format) }

    subject { get "/api/v1/orders/#{order.id}", headers: headers }

    it 'returns a order' do
      subject
      expect(response.parsed_body).to include_json(expected_body)
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /api/v1/orders' do
    let(:order_creator_params) { params[:order] }

    subject { post "/api/v1/orders", params: params, headers: headers }

    context 'valid order' do
      before do
        allow(OrderCreator).to receive(:run!).with(order_creator_params)
      end

      it 'returns success status' do
        subject
        expect(response.parsed_body).to eq('status' => 'success')
        expect(response.status).to eq(200)
        expect(OrderCreator).to have_received(:run!).with(order_creator_params)
      end
    end

    context 'when low stock invalidates order' do
      let(:stock_one) { 0 }
      let(:error_message) { 'Some error' }
      let(:error) { ActiveInteraction::InvalidInteractionError.new(error_message) }

      before do
        allow(OrderCreator).to receive(:run!)
          .with(order_creator_params).and_raise(error)
      end

      it 'returns failed status' do
        subject
        expect(response.parsed_body).to eq('status' => 'failed', 'errors' => [error_message])
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH /api/v1/orders/:id' do
    let(:order) { create :order, user: user }
    let(:order_creator_params) { params[:order].merge(order: order) }

    subject { patch "/api/v1/orders/#{order.id}", params: params, headers: headers }

    context 'valid order' do
      before do
        allow(OrderCreator).to receive(:run!).with(order_creator_params)
      end

      it 'returns success status' do
        subject
        expect(response.parsed_body).to eq('status' => 'success')
        expect(response.status).to eq(200)
        expect(OrderCreator).to have_received(:run!).with(order_creator_params)
      end
    end

    context 'invalid order' do
      it 'returns failed status' do
        subject
        expect(response.parsed_body).to include_json(status: 'failed')
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /api/v1/orders/:id' do
    let(:order) { create :order, user: user }

    subject { delete "/api/v1/orders/#{order_id}", headers: headers }

    context 'when successful' do
      let(:order_id) { order.id }

      it 'returns success status' do
        subject
        expect(response.parsed_body).to eq('status' => 'success')
        expect(response.status).to eq(200)
      end

      it 'deletes one order' do
        expect { subject }.to change { Order.where(id: order_id).count }.by(-1)
      end
    end

    context 'when it fails' do
      let(:order_id) { 9 }

      it 'returns failed status' do
        subject
        expect(response.parsed_body).to eq('status' => 'failed')
        expect(response.status).to eq(422)
      end
    end
  end
end
