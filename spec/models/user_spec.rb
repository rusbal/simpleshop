require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:orders) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  context 'with user instance' do
    let(:user) { create :user }
    let(:password) { 'password' }

    describe 'alias method' do
      let(:valid_password_result) { user.valid_password?(password) }
      let(:authenticate_result) { user.authenticate(password) }

      it 'defines alias authenticate for valid_password?' do
        expect(valid_password_result).to eq(authenticate_result)
      end
    end

    describe '.from_token_payload' do
      let(:payload) do
        { 'sub' => user.id }
      end

      subject { described_class.from_token_payload(payload) }

      before do
        allow(described_class).to receive(:find).with(payload['sub'])
      end

      it 'invokes find with sub as parameter' do
        expect(described_class).to receive(:find).with(payload['sub'])
        subject
      end
    end
  end
end
