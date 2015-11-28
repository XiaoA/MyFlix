require 'spec_helper'

feature "Signing in" do
  scenario "Signing in with valid inputs" do
    sherlock = Fabricate(:user)
    sign_in(sherlock)
    expect(page).to have_content "Welcome."
  end  
end
