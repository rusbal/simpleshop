require 'rails_helper'

RSpec.describe Region, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:currency) }
  end
end