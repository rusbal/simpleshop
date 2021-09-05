require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :request do
  describe "POST /api/v1/users" do
    let(:name) { Faker::Name.name }
    let(:email) { Faker::Internet.email }
    let(:params) do
      { registration: {
          name: name,
          email: email,
          password: 'password'
        }
      }
    end

    subject { post '/api/v1/users', params: params }

    it 'returns success status' do
      subject
      expect(response.parsed_body).to eq('status' => 'success')
      expect(response.status).to eq(200)
    end

    it 'creates one customer' do
      expect { subject }.to change { User.where(email: email).count }.by(1)
    end
  end
end
