require "rails_helper"

RSpec.describe RegionPolicy, type: :policy do
  # See https://actionpolicy.evilmartians.io/#/testing?id=rspec-dsl
  #
  let(:user) { build_stubbed(:user) }
  let(:region) { build_stubbed(:region) }

  let(:policy) { described_class.new(region, user: user) }

  describe "#show?" do
    subject { policy.apply(:show?) }

    it { is_expected.to eq true }

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end

  describe "#create?" do
    subject { policy.apply(:create?) }

    it "returns false when the user is not admin" do
      is_expected.to eq false
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end

  describe "#update?" do
    subject { policy.apply(:update?) }

    it "returns false when the user is not admin" do
      is_expected.to eq false
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end

  describe "#delete?" do
    subject { policy.apply(:delete?) }

    it "returns false when the user is not admin" do
      is_expected.to eq false
    end

    context "when the user is admin" do
      let(:user) { build_stubbed(:user, :admin) }

      it { is_expected.to eq true }
    end
  end
end
