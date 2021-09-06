def create_users
  User.destroy_all
  create_user('raymond@philippinedev.com', admin: true)
  15.times { create_user(Faker::Internet.email) }
  p "Created #{User.count} users."
end

def create_user(email, admin: false)
  user = User.new(email: email, name: Faker::Name.name, admin: admin)
  user.password = 'password'
  user.password_confirmation = 'password'
  user.skip_confirmation!
  user.save!
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

def create_orders
  OrderItem.destroy_all
  Order.destroy_all

  10.times do
    FactoryBot.create(:order_item)
  end
end

create_users
create_regions_and_products
create_orders
