require "faker"
require "yaml"

class User < ActiveRecord::Base
end

class Buyer < User
  has_many :orders
end

class Seller < User
  has_many :orders
end

class Order < ActiveRecord::Base
  belongs_to :buyer
  belongs_to :seller
end

def years_and_months
  (Date.parse("2015-01-01")..Date.parse("2017-08-01"))
    .map { |d| [d.year, d.month] }
    .uniq
end

# returns a random second inside a given month
def fake_second_for(year, month)
  Time.utc(year, month, 1) + rand(2419200)
end

COUNTRIES = YAML.load_file("db/seeds/seller_country.yaml")

def seller_country(buyer_country, year, month)
  COUNTRIES[buyer_country][year][month].sample
end

100.times do
  years_and_months.each do |year, month|
    buyer_country = COUNTRIES.keys.sample
    seller_country = seller_country(buyer_country, year, month)
    seller = Seller.create(name: Faker::Name.name, country: seller_country)
    buyer = Buyer.create(name: Faker::Name.name, country: buyer_country)
    Order.create(
      seller: seller,
      buyer: buyer,
      timestamp: fake_second_for(year, month)
    )
  end
end

