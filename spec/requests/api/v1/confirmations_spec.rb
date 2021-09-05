require 'rails_helper'

RSpec.describe Api::V1::ConfirmationsController, type: :request do
  describe "GET /api/v1/users/confirmation?confirmation_token=token-string" do
    let(:user) { create :user }
    let(:token) { 'token-string' }
    let(:params) do
      {
        confirmation_token: token
      }
    end

    before do
      allow(User).to receive(:find_by).with(confirmation_token: token).and_return(user)
    end

    context 'when successful' do
      before do
        allow(user).to receive(:confirm).with(no_args).and_return(true)
        subject
      end

      subject { get '/api/v1/users/confirmation', params: params }

      it 'returns success message' do
        expect(response.parsed_body).to eq('Your registration was successfully confirmed.')
        expect(response.status).to eq(200)
      end
    end

    context 'when failure' do
      before do
        allow(user).to receive(:confirm).with(no_args).and_return(false)
        subject
      end

      subject { get '/api/v1/users/confirmation', params: params }

      it 'returns success message' do
        expect(response.parsed_body).to eq('Attempt to confirm your registration failed.')
        expect(response.status).to eq(422)
      end
    end
  end
end
