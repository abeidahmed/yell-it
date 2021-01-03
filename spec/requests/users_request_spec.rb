require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "#create" do
    it "does create a new user if the fields are valid" do
      post users_path, params: { user: attributes_for(:user).except(:auth_token) }

      expect(User.count).to eq(1)
      expect(cookies[:auth_token]).to eq(User.first.auth_token)
    end

    it "returns an error if fields are invalid" do
      post users_path, params: { user: attributes_for(:user).except(:auth_token, :email_address) }

      expect(json.dig(:errors, :email_address)).to be_present
    end
  end
end
