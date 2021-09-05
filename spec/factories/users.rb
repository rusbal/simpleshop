FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password ' }
    password_confirmation { 'password ' }
    confirmation_token { Faker::Alphanumeric.alphanumeric(number: 40) }
    confirmed_at { DateTime.current }
    confirmation_sent_at { DateTime.current }
    name { Faker::Name.name }
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end
