require 'rails_helper'

RSpec.describe Region, type: :model do
  describe 'relationships' do
    it { should have_many(:products) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:currency) }
    it { should validate_presence_of(:tax) }
  end
end
