require 'spec_helper'

feature "Reviews" do 
  let(:user) { Fabricate(:user) }
  let(:business) { Fabricate(:business) }

  scenario "creating a review" do 
    visit login_path
    within("#login") do 
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_button 'Login'
    visit business_path(business)
    within('#add-review') do 
      select "2 stars", from: 'Rating'
      fill_in 'Description', with: 'Example content.'
    end
    click_button 'Add review'
    within("ul.reviews") do 
      expect(page).to have_content("Example content")
      expect(page).to have_content("2 / 5")
      expect(page).to have_content(user.username)
    end
  end
end