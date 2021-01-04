require "rails_helper"

RSpec.describe Project, type: :model do
  subject(:project) { build(:project) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_length_of(:name).is_at_most(255) }

    it { is_expected.to validate_length_of(:subdomain).is_at_most(63) }

    it { is_expected.to validate_uniqueness_of(:subdomain).case_insensitive }
  end

  describe "before saving" do
    it "does lowercase subdomain" do
      subdomain = "helloworld"
      project   = create(:project, subdomain: subdomain.upcase)
      expect(project.reload.subdomain).to eq(subdomain)
    end

    it "does not throw error when lowercasing nil values" do
      project = create(:project, subdomain: nil)
      expect(project.reload.subdomain).to eq("")
    end
  end
end
