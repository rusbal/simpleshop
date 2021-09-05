FactoryBot.define do
  factory :order do
    shipping_address { Faker::Address.full_address }
    total { rand(1000..999999) }
    user
  end
end
