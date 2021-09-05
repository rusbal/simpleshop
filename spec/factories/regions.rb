FactoryBot.define do
  factory :region do
    title { ["Regiona", "Regionb", "Regionc", "Regiond", "Regione"].sample }
    country { Faker::Address.country }
    currency { Faker::Currency.code }
    tax { 10 }
  end
end
