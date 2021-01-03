require "rails_helper"

RSpec.describe "SignUps", type: :feature do
  it "after signing up it should redirect to home page" do
    visit new_user_path
    fill_in "user[full_name]", with: "John Doe"
    fill_in "user[email_address]", with: "hello@example.com"
    fill_in "user[password]", with: "secrettt"
    click_button "Create account"

    expect(page).to have_current_path(root_path)
  end

  it "will take me to sign in page if I click on sign in link" do
    visit new_user_path
    click_link "Sign in"

    expect(page).to have_current_path(new_session_path)
  end
end
