require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:another_user_id) { 1000 }
  let!(:user2) do
    create(:user,
           id: another_user_id,
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
  let(:expected_another_user) do
    {
      "admin" => false,
      "confirmed_at" => "2000-01-01T00:00:00.000Z",
      "email" => "another@gmail.com",
      "id" => 1000,
      "name" => "Pepe"
    }
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
          expected_another_user,
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

  describe 'GET #show' do
    context 'with customer' do
      let(:admin) { false }
      let(:user) { create(:user, email: email, confirmed_at: confirmed_at, name: name) }
      let(:expected_users) do
        {
          "admin" => admin,
          "confirmed_at" => "2000-01-01T00:00:00.000Z",
          "email" => "raymond@philippinedev.com",
          "id" => user.id,
          "name" => "Raymond Usbal"
        }
      end

      describe "GET /api/v1/users/:id" do
        context 'viewing own record' do
          subject { get "/api/v1/users/#{user.id}", headers: headers }

          it 'one user' do
            subject
            expect(response.parsed_body).to eq expected_users
          end
        end

        context 'viewing record of other users' do
          subject { get "/api/v1/users/#{user2.id}", headers: headers }

          it 'one user' do
            expect { subject }.to raise_error ActionPolicy::Unauthorized
          end
        end
      end
    end

    context 'with admin' do
      let(:admin) { true }
      let(:user) { create(:user, :admin, email: email, confirmed_at: confirmed_at, name: name) }
      let(:expected_users) do
        {
          "admin" => admin,
          "confirmed_at" => "2000-01-01T00:00:00.000Z",
          "email" => "raymond@philippinedev.com",
          "id" => user.id,
          "name" => "Raymond Usbal"
        }
      end

      describe "GET /api/v1/users/:id" do
        context 'viewing own record' do
          subject { get "/api/v1/users/#{user.id}", headers: headers }

          it 'one user' do
            subject
            expect(response.parsed_body).to eq expected_users
          end
        end

        context 'viewing record of other users' do
          subject { get "/api/v1/users/#{user2.id}", headers: headers }

          it 'one user' do
            subject
            expect(response.parsed_body).to eq expected_another_user
          end
        end
      end
    end
  end
end
