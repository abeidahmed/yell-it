require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "#create" do
    let(:user) { create(:user) }

    it "will sign-in user when request is valid" do
      post sessions_path, params: { email_address: user.email_address, password: user.password }

      expect(cookies[:auth_token]).to eq(user.auth_token)
    end

    it "returns error when sign-in is invalid" do
      post sessions_path, params: { email_address: "hello@ex.com", password: user.password }

      expect(json.dig(:errors, :invalid)).to be_present
    end
  end

  describe "#destroy" do
    it "will sign out the user" do
      sign_in
      delete session_path("current_user")

      expect(cookies[:auth_token]).to be_blank
    end
  end
end
