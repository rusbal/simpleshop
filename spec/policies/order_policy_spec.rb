require "rails_helper"

RSpec.describe OrderPolicy, type: :policy do
  # See https://actionpolicy.evilmartians.io/#/testing?id=rspec-dsl
  #
  let(:user) { build_stubbed(:user) }
  let(:order) { build_stubbed(:order) }

  let(:policy) { described_class.new(order, user: user) }

  let(:action) { :show? }
  subject { policy.apply(action) }

  describe "#show?" do
    context "when customer" do
      it { is_expected.to eq false }

      context "when customer owns the order" do
        let(:order) { build_stubbed(:order, user: user) }

        it { is_expected.to eq true }
      end
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end

  describe "#create?" do
    let(:action) { :create? }

    it "allows all to create an order" do
      is_expected.to eq true
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end

  describe "#update?" do
    let(:action) { :update? }

    context "as customer" do
      it "prohibits when the user is not admin" do
        is_expected.to eq false
      end

      context "when order is created by customer" do
        let(:order) { build_stubbed(:order, user: user) }

        it "allows for own orders" do
          is_expected.to eq true
        end
      end
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end

  describe "#delete?" do
    let(:action) { :delete? }

    context "as customer" do
      it "prohibits when the user is not admin" do
        is_expected.to eq false
      end

      context "when order is created by customer" do
        let(:order) { build_stubbed(:order, user: user) }

        it "allows for own orders" do
          is_expected.to eq true
        end
      end
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end

  describe "#destroy?" do
    let(:action) { :destroy? }

    context "as customer" do
      it "prohibits when the user is not admin" do
        is_expected.to eq false
      end

      context "when order is created by customer" do
        let(:order) { build_stubbed(:order, user: user) }

        it "allows for own orders" do
          is_expected.to eq true
        end
      end
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end
end
