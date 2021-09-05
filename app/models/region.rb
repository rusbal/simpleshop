class Region < ApplicationRecord
  validates :title, presence: true
  validates :country, presence: true
  validates :currency, presence: true
end
