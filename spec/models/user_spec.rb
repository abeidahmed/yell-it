require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe "validations" do
    it { is_expected.to have_secure_password }

    it { is_expected.to validate_presence_of(:email_address) }

    it { is_expected.to validate_uniqueness_of(:email_address).case_insensitive }

    it { is_expected.to validate_length_of(:email_address).is_at_most(255) }

    it { is_expected.to allow_value("abeidmama@example.com", "abeidm@em.uk.com").for(:email_address) }

    it { is_expected.not_to allow_value("abeidmama", "abeidm@em@.com").for(:email_address) }

    it { is_expected.to validate_presence_of(:full_name) }

    it { is_expected.to validate_length_of(:full_name).is_at_most(255) }

    it "does lowercase email_address before saving" do
      user.email_address = user.email_address.upcase
      user.save!
      expect(user.reload.email_address).to eq(user.email_address.downcase)
    end

    it { is_expected.to validate_length_of(:password).is_at_least(6) }

    context "when creating a new user" do
      it "will set auth_token with Secure Random hash" do
        user.auth_token = nil
        user.save!
        expect(user.reload.auth_token).not_to be_nil
      end

      it "will trim excess white spaces from email address" do
        user.email_address = "       email@example.com "
        user.save!
        expect(user.email_address).to eq("email@example.com")
      end

      it "will trim excess white spaces from full name" do
        user.full_name = "   John Doe "
        user.save!
        expect(user.full_name).to eq("John Doe")
      end
    end
  end
end
