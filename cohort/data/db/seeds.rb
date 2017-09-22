require "faker"

class Product < ActiveRecord::Base
  belongs_to :user
end

class User < ActiveRecord::Base
  has_many :products
end

# randomly decide if user added product
def months_with_a_product_added
  12.times { |month| yield(month+1) if rand(2) > 0 }
end

# returns a random second inside a given month
def fake_second_for(month)
  Time.utc(2016, month, 1) + rand(2419200)
end

500.times do
  user = User.create(name: Faker::Name.name)
  months_with_a_product_added do |month|
    Product.create(
      name: Faker::Beer.name,
      user: user,
      added_on: fake_second_for(month)
    )
  end
end
