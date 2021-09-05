require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'relationships' do
    it { should belong_to(:region) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:image_url) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:sku) }
    it { should validate_presence_of(:stock) }
  end
end
