require 'spec_helper'

feature "Signing in" do
  scenario "Signing in with valid inputs" do
    sherlock = Fabricate(:user)
    visit sign_in_path
    fill_in 'Email',  with: sherlock.email
    fill_in 'Password', with: sherlock.password

    click_button 'Sign In'

    expect(page).to have_content "Welcome."
  end  
end
