require "rails_helper"

RSpec.describe UserPolicy, type: :policy do
  let(:user) { build_stubbed(:user) }
  let(:policy) { described_class.new(user, user: user) }

  let(:action) { :show? }
  subject { policy.apply(action) }

  describe "#show?" do
    it { is_expected.to eq true }

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end

  describe "#create?" do
    let(:action) { :create? }

    it { is_expected.to eq true }
  end

  describe "#update?" do
    let(:action) { :update? }

    it "returns false when the user is not admin" do
      is_expected.to eq true
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end

  describe "#delete?" do
    let(:action) { :delete? }

    it "returns false when the user is not admin" do
      is_expected.to eq true
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end

  describe "#destroy?" do
    let(:action) { :destroy? }

    it "returns false when the user is not admin" do
      is_expected.to eq true
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end
end
