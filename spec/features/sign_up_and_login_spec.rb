require 'spec_helper'

feature "user creation and authentication" do 
  scenario "signing up for an account and logging in" do 
    visit root_path
    expect(page).to have_content("Sign up")
    expect(page).to have_content("Login")
    click_link "Sign up"
    within("#new_user") do 
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Username', with: 'Example Name'
      fill_in 'Password', with: 'password'
    end
    click_button 'Create User'
    click_link "Login"
    within("#login") do 
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Login'
    expect(page).to have_content("Example Name")
    expect(page).not_to have_content("Login")
    expect(page).not_to have_content("Sign up")
  end
end