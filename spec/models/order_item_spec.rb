require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:price) }
  end
end
