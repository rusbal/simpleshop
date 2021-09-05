require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:shipping_address) }
    it { should validate_presence_of(:total) }
  end

  context 'with instance' do
    let(:paid_at) { nil }
    let(:order) { create :order, paid_at: paid_at }

    describe '#payment_status' do
      describe 'when unpaid' do
        it 'returns unpaid' do
          expect(order.payment_status).to eq('unpaid')
        end
      end

      describe 'when paid' do
        let(:paid_at) { DateTime.current }

        it 'returns paid' do
          expect(order.payment_status).to eq('paid')
        end
      end
    end
  end
end
