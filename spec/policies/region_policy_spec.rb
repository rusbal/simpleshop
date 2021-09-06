require "rails_helper"

RSpec.describe RegionPolicy, type: :policy do
  # See https://actionpolicy.evilmartians.io/#/testing?id=rspec-dsl
  #
  let(:user) { build_stubbed(:user) }
  let(:region) { build_stubbed(:region) }

  let(:policy) { described_class.new(region, user: user) }

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

    it "returns false when the user is not admin" do
      is_expected.to eq false
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end

  describe "#update?" do
    let(:action) { :update? }

    it "returns false when the user is not admin" do
      is_expected.to eq false
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end

  describe "#delete?" do
    let(:action) { :delete? }

    it "returns false when the user is not admin" do
      is_expected.to eq false
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end

  describe "#destroy?" do
    let(:action) { :destroy? }

    it "returns false when the user is not admin" do
      is_expected.to eq false
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end
end
