require "rails_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  describe "order_payment_status" do
    let(:order) { create(:order) }
    let(:mail) { NotificationsMailer.order_payment_status(order) }

    it "renders the headers" do
      expect(mail.subject).to eq("Order payment status")
      expect(mail.to).to eq([order.user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    context "order status" do
      let(:status) { 'paid' }
      let(:expected_body) { "Your order payment status is #{status}." }

      before do
        allow(order).to receive(:payment_status).with(no_args).and_return(status)
      end

      it "renders the body" do
        expect(mail.body.encoded).to match(expected_body)
      end
    end
  end

end
