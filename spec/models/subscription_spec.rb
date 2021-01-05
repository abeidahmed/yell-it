require "rails_helper"

RSpec.describe Subscription, type: :model do
  subject(:subscription) { build(:subscription) }

  describe "associations" do
    it { is_expected.to belong_to(:project) }
  end

  describe "validations" do
    it { is_expected.to validate_uniqueness_of(:project) }
  end
end
