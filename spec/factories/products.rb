FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name }
    description { Faker::Company.bs }
    image_url { Faker::LoremFlickr.image }
    price { Faker::Commerce.price * 100 }
    sku { Faker::Internet.uuid }
    stock { rand(100) }
    region
  end
end
