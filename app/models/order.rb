class Order < ApplicationRecord
  belongs_to :user

  validates :shipping_address, presence: true
  validates :total, presence: true

  def payment_status
    paid_at.present? ? 'paid' : 'unpaid'
  end
end
