require "rails_helper"

RSpec.describe "SignIns", type: :feature do
  it "will redirect to root_path after signing up" do
    feature_sign_in

    expect(page).to have_current_path(root_path)
  end

  it "will take me to sign up page if I click on sign up link" do
    visit new_session_path
    click_link "Sign up"

    expect(page).to have_current_path(new_user_path)
  end
end
