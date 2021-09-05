require "rails_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  describe "order_payment_status" do
    let(:order) { create(:order) }
    let(:mail) { NotificationsMailer.order_payment_status(order) }

    it "renders the headers" do
      expect(mail.subject).to eq("Order payment status")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
