require "rails_helper"

RSpec.describe Membership, type: :model do
  subject(:membership) { build(:membership) }

  describe "associations" do
    it { is_expected.to belong_to(:project) }

    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    # rubocop:disable RSpec/ImplicitSubject, Layout/MultilineMethodCallIndentation
    it {
      is_expected.to validate_uniqueness_of(:user)
      .scoped_to(:project_id)
      .case_insensitive
      .with_message("is already on the project team")
    }

    it {
      is_expected.to define_enum_for(:role)
      .with_values(editor: "editor", owner: "owner")
      .backed_by_column_of_type(:string)
    }
    # rubocop:enable RSpec/ImplicitSubject, Layout/MultilineMethodCallIndentation
  end
end
