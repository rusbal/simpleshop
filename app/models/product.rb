class Product < ApplicationRecord
  belongs_to :region

  validates :title, presence: true
  validates :description, presence: true
  validates :image_url, presence: true
  validates :price, presence: true
  validates :sku, presence: true
  validates :stock, presence: true
end
