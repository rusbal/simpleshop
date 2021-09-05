class Region < ApplicationRecord
  has_many :products

  validates :title, presence: true
  validates :country, presence: true
  validates :currency, presence: true
  validates :tax, presence: true
end
