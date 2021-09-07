require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let!(:user2) do
    create(:user,
           id: 1000,
           admin: false,
           email: 'another@gmail.com',
           confirmed_at: confirmed_at,
           name: 'Pepe')
  end
  let(:name) { 'Raymond Usbal' }
  let(:confirmed_at) { '2000-01-01 00:00:00'.to_datetime }
  let(:email) { 'raymond@philippinedev.com' }
  let(:token) { jwt_sign_in(email: user.email, password: user.password) }
  let(:headers) do
    { authorization: "JWT #{token}" }
  end
  let(:expected_users) do
    [
      {
        "admin" => admin,
        "confirmed_at" => "2000-01-01T00:00:00.000Z",
        "email" => "raymond@philippinedev.com",
        "id" => user.id,
        "name" => "Raymond Usbal"
      }
    ]
  end

  describe 'GET #index' do
    context 'with customer' do
      let(:admin) { false }
      let(:user) { create(:user, email: email, confirmed_at: confirmed_at, name: name) }

      describe "GET /api/v1/users" do
        subject { get '/api/v1/users', headers: headers }

        it 'returns a list of users' do
          subject
          expect(response.parsed_body).to eq expected_users
        end
      end
    end

    context 'with admin user' do
      let(:admin) { true }
      let(:user) { create(:user, :admin, email: email, confirmed_at: confirmed_at, name: name) }
      let(:expected_users) do
        [
          {
            "admin" => false,
            "confirmed_at" => "2000-01-01T00:00:00.000Z",
            "email" => "another@gmail.com",
            "id" => 1000,
            "name" => "Pepe"
          },
          {
            "admin" => admin,
            "confirmed_at" => "2000-01-01T00:00:00.000Z",
            "email" => "raymond@philippinedev.com",
            "id" => user.id,
            "name" => "Raymond Usbal"
          }
        ]
      end

      describe "GET /api/v1/users" do
        subject { get '/api/v1/users', headers: headers }

        it 'returns a list of users' do
          subject
          expect(response.parsed_body).to eq expected_users
        end
      end
    end
  end

  # describe 'GET #show' do
  #   context 'with customer' do
  #     let(:admin) { false }
  #     let(:user) { create(:user, email: email, confirmed_at: confirmed_at, name: name) }
  #     let!(:user2) { create(:user, email: 'another@gmail.com', confirmed_at: confirmed_at, name: 'Pepe') }
  #
  #     describe "GET /api/v1/users" do
  #       subject { get '/api/v1/users', headers: headers }
  #
  #       it 'returns a list of users' do
  #         subject
  #         expect(response.parsed_body).to eq expected_users
  #       end
  #     end
  #   end
  # end
end
