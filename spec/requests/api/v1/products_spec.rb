# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProductsController do
  let(:region) { create :region }
  let(:user) { create(:user, :admin) }
  let(:token) { jwt_sign_in(email: user.email, password: user.password) }
  let(:headers) do
    { authorization: "JWT #{token}" }
  end
  let(:json_format) do
    {
      except: %i[
        created_at
        updated_at
      ]
    }
  end
  let(:region_id) { region.id }
  let(:title) { Faker::Commerce.product_name }
  let(:description) { Faker::Company.bs }
  let(:image_url) { Faker::LoremFlickr.image }
  let(:price) { (Faker::Commerce.price * 100).to_i }
  let(:sku) { Faker::Internet.uuid }
  let(:stock) { rand(100) }
  let(:params) do
    {
      product: {
        region_id: region_id,
        title: title,
        description: description,
        image_url: image_url,
        price: price,
        sku: sku,
        stock: stock
      }
    }
  end

  describe 'GET /api/v1/regions/:region_id/products' do
    let!(:products) { FactoryBot.create_list(:product, 3) }
    let(:expected_body) { products.as_json(json_format) }

    subject { get "/api/v1/regions/#{region_id}/products", headers: headers }

    it 'returns a list of products' do
      subject
      expect(response.parsed_body).to eq(expected_body)
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /api/v1/regions/:region_id/products/:id' do
    let!(:product) { create(:product) }
    let(:expected_body) { product.as_json(json_format) }

    subject { get "/api/v1/regions/#{region_id}/products/#{product.id}", headers: headers }

    it 'returns a product' do
      subject
      expect(response.parsed_body).to eq(expected_body)
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /api/v1/regions/:region_id/products' do
    let(:title) { nil }
    let(:product) { create :product }

    subject { post "/api/v1/regions/#{region_id}/products", params: params, headers: headers }

    context 'with invalid title' do
      it 'returns failed status' do
        subject
        expect(response.parsed_body).to eq('status' => 'failed')
        expect(response.status).to eq(422)
      end
    end

    context 'with valid title' do
      let(:title) { 'Productti' }

      it 'returns success status' do
        subject
        expect(response.parsed_body).to eq('status' => 'success')
        expect(response.status).to eq(200)
      end

      it 'creates one product' do
        expect { subject }.to change { Product.where(title: title).count }.by(1)
      end
    end
  end

  describe 'PATCH /api/v1/regions/:region_id/products/:id' do
    let(:old_stock) { 100 }
    let!(:product) { create :product, title: 'Yellow', stock: old_stock }
    let(:title) { nil }

    subject { patch "/api/v1/regions/#{region_id}/products/#{product.id}", params: params, headers: headers }

    context 'with valid title' do
      let(:title) { 'Productti' }

      it 'returns success status' do
        subject
        expect(response.parsed_body).to eq('status' => 'success')
        expect(response.status).to eq(200)
      end

      it 'creates one product' do
        expect { subject }.to change { Product.where(title: title).count }.by(1)
      end
    end

    context 'with invalid title' do
      it 'returns failed status' do
        subject
        expect(response.parsed_body).to eq('status' => 'failed')
        expect(response.status).to eq(422)
      end
    end

    describe 'updating of stock' do
      let(:user) { create :user }
      let(:new_stock) { 200 }
      let(:params) do
        {
          product: { stock: new_stock }
        }
      end

      context 'customer cannot update stock' do
        it 'raises error' do
          expect { subject }.to raise_error ActionPolicy::Unauthorized
        end
      end

      context 'admin can update stock' do
        let(:user) { create :user, :admin }

        it 'creates one product' do
          expect { subject }.to change { Product.where(stock: 200).count }.by(1)
          product.reload
          expect(product.stock).to eq new_stock
        end
      end
    end
  end

  describe 'DELETE /api/v1/regions/:region_id/products/:id' do
    subject { delete "/api/v1/regions/#{region_id}/products/#{product_id}", headers: headers }

    context 'when successful' do
      let(:title) { 'Productti' }
      let!(:product) { create(:product, title: title) }
      let(:product_id) { product.id }

      it 'returns success status' do
        subject
        expect(response.parsed_body).to eq('status' => 'success')
        expect(response.status).to eq(200)
      end

      it 'deletes one product' do
        expect { subject }.to change { Product.where(title: title).count }.by(-1)
      end
    end

    context 'when it fails' do
      let(:product_id) { 9 }

      it 'returns failed status' do
        subject
        expect(response.parsed_body).to eq('status' => 'failed')
        expect(response.status).to eq(422)
      end
    end
  end
end
