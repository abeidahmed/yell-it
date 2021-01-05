require "rails_helper"

RSpec.describe Project, type: :model do
  subject(:project) { build(:project) }

  describe "associations" do
    it { is_expected.to have_many(:users) }

    it { is_expected.to have_many(:memberships) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_length_of(:name).is_at_most(255) }

    it { is_expected.to validate_length_of(:subdomain).is_at_most(63) }

    it { is_expected.to validate_presence_of(:subdomain) }

    it { is_expected.to validate_uniqueness_of(:subdomain).case_insensitive }

    # rubocop:disable RSpec/ImplicitSubject, Layout/MultilineMethodCallIndentation
    it {
      is_expected.to define_enum_for(:plan)
      .with_values(free: "free", premium: "premium")
      .backed_by_column_of_type(:string)
    }
    # rubocop:enable RSpec/ImplicitSubject, Layout/MultilineMethodCallIndentation
  end

  describe "before saving" do
    it "does lowercase subdomain" do
      subdomain = "helloworld"
      project   = create(:project, subdomain: subdomain.upcase)
      expect(project.reload.subdomain).to eq(subdomain)
    end
  end
end
