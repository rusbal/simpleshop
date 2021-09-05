# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RegionsController do
  let(:user) { create(:user) }
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
  let(:title) { 'Asia-Pacific' }
  let(:country) { 'Philippines' }
  let(:currency) { 'PHP' }
  let(:tax) { 10 }
  let(:params) do
    {
      region: {
        title: title,
        country: country,
        currency: currency,
        tax: tax
      }
    }
  end

  describe 'GET /regions/:id' do
    let!(:region) { create(:region) }
    let(:expected_body) { region.as_json(json_format) }

    subject { get "/api/v1/regions/#{region.id}", headers: headers }

    it 'returns a region' do
      subject
      expect(response.parsed_body).to include_json(expected_body)
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /regions' do
    let(:title) { nil }
    let(:album) { create :album }

    subject { post "/api/v1/regions", params: params, headers: headers }

    context 'with valid title' do
      let(:title) { 'Regionti' }

      it 'returns success status' do
        subject
        expect(response.parsed_body).to eq('status' => 'success')
        expect(response.status).to eq(200)
      end

      it 'creates one region' do
        expect { subject }.to change { Region.where(title: title).count }.by(1)
      end
    end

    context 'with invalid title' do
      it 'returns failed status' do
        subject
        expect(response.parsed_body).to eq('status' => 'failed')
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH /regions/:id' do
    let(:album) { create :region, title: 'Yellow' }
    let(:title) { nil }

    subject { patch "/api/v1/regions/#{album.id}", params: params, headers: headers }

    context 'with valid title' do
      let(:title) { 'Regionti' }

      it 'returns success status' do
        subject
        expect(response.parsed_body).to eq('status' => 'success')
        expect(response.status).to eq(200)
      end

      it 'creates one album' do
        expect { subject }.to change { Region.where(title: title).count }.by(1)
      end
    end

    context 'with invalid title' do
      it 'returns failed status' do
        subject
        expect(response.parsed_body).to eq('status' => 'failed')
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /regions/:id' do
    subject { delete "/api/v1/regions/#{album_id}", headers: headers }

    context 'when successful' do
      let(:title) { 'Regionti' }
      let!(:region) { create(:region, title: title) }
      let(:album_id) { region.id }

      it 'returns success status' do
        subject
        expect(response.parsed_body).to eq('status' => 'success')
        expect(response.status).to eq(200)
      end

      it 'deletes one region' do
        expect { subject }.to change { Region.where(title: title).count }.by(-1)
      end
    end

    context 'when it fails' do
      let(:album_id) { 9 }

      it 'returns failed status' do
        subject
        expect(response.parsed_body).to eq('status' => 'failed')
        expect(response.status).to eq(422)
      end
    end
  end
end
