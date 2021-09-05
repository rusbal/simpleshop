def create_users
  User.destroy_all
  15.times do
    user = User.new(email: Faker::Internet.email, name: Faker::Name.name)
    user.password = 'password'
    user.password_confirmation = 'password'
    user.skip_confirmation!
    user.save!
  end
  p "Created #{User.count} users."
end

def create_regions_and_products
  Product.destroy_all
  Region.destroy_all

  50.times do
    region = FactoryBot.create(:region)
    rand(1..10).times do
      FactoryBot.create(:product, region: region)
    end
  end

  p "Created #{Region.count} regions."
  p "Created #{Product.count} products."
end

create_users
create_regions_and_products
