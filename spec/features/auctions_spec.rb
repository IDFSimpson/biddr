require 'rails_helper'

RSpec.feature "Auctions", type: :feature do
  describe "with valid auction data" do

    before { capybara_sign_in }

    it "shows the new auction" do
      visit new_auction_path

      valid_attributes = FactoryGirl.attributes_for(:auction)

      fill_in "Title", with: valid_attributes[:title]
      fill_in "Details", with: valid_attributes[:details]
      fill_in "Ends", with: valid_attributes[:ends]
      fill_in "Reserve price", with: valid_attributes[:reserve_price]

      click_button "Submit"
      
      expect(page).to have_text /#{valid_attributes[:title]}/i
      expect(page).to have_text /#{valid_attributes[:details][0..10]}/i
      expect(page).to have_text /#{valid_attributes[:ends].day}/i
      expect(page).to have_text /#{valid_attributes[:reserve_price].to_s[-3..-1]}/i
      expect(page).to have_text /Auction was successfully created/i

    end
  end

  describe "with invalid auction data" do

    before { capybara_sign_in }

    it "shows the auction" do
      visit new_auction_path

      click_button "Submit"

      expect(page).to have_text /can't be blank/i
    end
  end

  private

  def capybara_sign_in
    user_attributes = FactoryGirl.attributes_for(:user)
    User.create user_attributes

    visit new_user_session_path

    fill_in "Email", with: user_attributes[:email]
    fill_in "Password", with: user_attributes[:password]

    click_button "Log in"

    expect(current_path).to eq(root_path)

  end


end
