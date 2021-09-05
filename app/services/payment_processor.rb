class PaymentProcessor < ActiveInteraction::Base
  def execute
    [true, false].sample
  end
end
