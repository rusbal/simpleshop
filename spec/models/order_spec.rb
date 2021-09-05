require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:shipping_address) }
    it { should validate_presence_of(:total) }
  end
end
