class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :orders

  validates :name, presence: true

  alias_method :authenticate, :valid_password?

  def self.from_token_payload(payload)
    self.find payload['sub']
  end
end
