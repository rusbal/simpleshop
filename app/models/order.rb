class Order < ApplicationRecord
  belongs_to :user

  validates :shipping_address, presence: true
  validates :total, presence: true
end
