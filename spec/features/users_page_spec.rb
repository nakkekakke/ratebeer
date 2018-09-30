require 'rails_helper'

include Helpers

describe "User" do
  let!(:user) { FactoryBot.create :user }

  it "is added to the system after signing up with proper credentials" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')
    expect {
      click_button('Create User')      
    }.to change{ User.count }.by(1)
  end

  it "page shows all of the user's ratings" do
    brewery = FactoryBot.create :brewery, name: 'TastyBrewery'
    beer = FactoryBot.create :beer, name: 'TastyBeer', brewery: brewery
    ratings = [15, 20, 25]
    ratings.each do |score|
      FactoryBot.create :rating, score: score, beer: beer, user: user
    end

    visit user_path(user)

    expect(page).to have_content "Ratings"

    ratings.each do |rating|
      expect(page).to have_content(rating)
    end

    
  end

  describe "who has signed up" do
    it "can sign in with the right credentials" do
      sign_in(username: 'Pekka', password: 'Foobar1')

      expect(page).to have_content 'Welcome back, Pekka'
    end

    it "is redirected back to sign in form if wrong credentials were given" do
      sign_in(username: 'Pekka', password: 'wrong')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Wrong username or password'
    end
  end
end